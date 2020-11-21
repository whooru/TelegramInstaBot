import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.net.URL;
import java.util.Set;

public class Browser {
    private String nickname;
    private WebDriver wdriver;
    private JavascriptExecutor js;
    private String height;
    private Set<String> photos;

    public Set<String> getPhotos() {
        return photos;
    }

    public Browser(String nickname) throws InterruptedException {
        this.nickname = nickname;
        System.setProperty("webdriver.chrome.driver", "D:/chromedriver/chromedriver.exe");
        wdriver = new ChromeDriver();
        wdriver.get("https://www.instagram.com/" + nickname);
        js = (JavascriptExecutor) wdriver;
        wdriver.manage().window().maximize();
        height = wdriver.findElement(By.tagName("section")).getCssValue("height");
        Parser parser = new Parser(height, wdriver, js, nickname);
        parser.start();
        parser.join();
        this.photos = parser.getPhotos();
    }
}
