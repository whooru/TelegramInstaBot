import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Set;

public class Parser extends Thread implements Runnable {
    private String height;
    private WebDriver wdriver;
    private JavascriptExecutor js;
    private String newHeight;
    private String nickname;
    private Set<String> photos = new HashSet<String>();
    private Set<String> downloadedPhotos = new HashSet<String>();
    private int i;

    public Set<String> getPhotos() {
        return photos;
    }

    public Parser(String height, WebDriver wdriver, JavascriptExecutor js, String nickname) {
        this.height = height;
        this.wdriver = wdriver;
        this.js = js;
        this.nickname = nickname;

    }
    //скролим страницу попутно собирая все фотографии
    @Override
    public void run() {
        try {
            Files.createDirectories(Paths.get("src/main/resources/photos/" + nickname));
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("error");
        }
        while (true) {
            try {
                newHeight = scrollPage(height, wdriver, js);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (newHeight.equals(height)) {
                break;
            }
            height = newHeight;
        }
        wdriver.quit();
    }

    //функция скроллина страницы
    //опускаем страницу в самый низ, обновляем высоту, запускаем парсер(сбор фото с данного участка)
    public String scrollPage(String height, WebDriver driver, JavascriptExecutor js) throws InterruptedException {
        String newHeight;
        js.executeScript("window.scrollBy(0,document.body.scrollHeight)");
        Thread.sleep(1500);
        newHeight = driver.findElement(By.tagName("section")).getCssValue("height");
        System.out.println(height);
        Parsing parsing = new Parsing(nickname, driver.getPageSource());
        parsing.start();
        return newHeight;
    }

    public class Parsing extends Thread implements Runnable {
        String url;
        String source;

        public Parsing(String url, String source) {
            this.url = url;
            this.source = source;
        }
        //запускаем нить парсинга учатска, после сбора всех фото сразу их качаем
        @Override
        public void run() {
            parse(source);
            for (String photoUrl : photos) {

                    if (!downloadedPhotos.contains(photoUrl)) {
                        DownloadPhotos(photoUrl);
                        downloadedPhotos.add(photoUrl);

                }
            }
        }
    }
    //парсим полученный код страницы, проверяем все img на наличиее соотвутсвующего класса,
    // добавляем их в сет, что бы не было дублей
    public String parse(String source) {
        Document doc = Jsoup.parse(source);
        Element title;
        int i = 0;
        while (true) {
            try {
                title = doc.getElementsByTag("img").get(i);
                Document doc2 = Jsoup.parse(title + "");
                String iUrl = doc2.getElementsByTag("img").first().attr("src");
                i++;
                if (doc2.getElementsByTag("img").first().className().equals("FFVAD")) {
                    photos.add(iUrl);
                }
            } catch (IndexOutOfBoundsException e) {
                break;
            }
        }

        return null;
    }
    //качаем фото в директорию с соотвутсвующим названием
    public synchronized void DownloadPhotos(String url) {
        if (url.split("/")[0].equals("https:")) {
            try {
                InputStream in = new URL(url).openStream();
                try {
                    System.out.println("download " + url);
                    Files.copy(in, Paths.get("src/main/resources/photos/" + nickname + "/image" + i + ".jpg"));
                    in.close();
                    i++;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                System.out.println("Can't download");
                e.printStackTrace();
            }
        }
    }


}
