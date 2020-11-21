import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

public class DownloadOnePhoto {
    private String url;
    private String photo;


    public DownloadOnePhoto(String url) {
        this.url = url;
    }

    public void download()  {
        try {
            Files.createDirectories(Paths.get("src/main/resources/photos/" + url.split("/")[4]));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.setProperty("webdriver.chrome.driver", "D:/chromedriver/chromedriver.exe");
        WebDriver wdriver = new ChromeDriver();
        wdriver.get(url);
        System.out.println("i'm here in download");
        JavascriptExecutor js = (JavascriptExecutor) wdriver;
        wdriver.manage().window().maximize();
        Document doc = Jsoup.parse(wdriver.getPageSource());
        wdriver.close();
        Element title;
        int i = 0;
        while (true) {
            try {
                title = doc.getElementsByTag("img").get(i);
                Document doc2 = Jsoup.parse(title + "");
                String iUrl = doc2.getElementsByTag("img").first().attr("src");
                i++;
                if (doc2.getElementsByTag("img").first().className().equals("FFVAD")) {
                    photo = iUrl;
                    if (url.split("/")[0].equals("https:")) {
                        try {
                            InputStream in = new URL(photo).openStream();
                            try {
                                System.out.println("download " + photo);
                                Files.copy(in, Paths.get("src/main/resources/photos/" + url.split("/")[4] + "/image.jpg"));
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

            } catch (IndexOutOfBoundsException e) {
                break;
            }
        }

    }
}
