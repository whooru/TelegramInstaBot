import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class MakeZip {
    private String nickname;

    public MakeZip(String nickname) {
        this.nickname = nickname;
    }

    public void makeZip() {
        int i = 0;
        String filename = "C:/SomeDir/notes.txt";
        File folder = new File("src/main/resources/photos/" + nickname);
        try {
            ZipOutputStream zout = new ZipOutputStream(new FileOutputStream("src/main/resources/photos/" + nickname + "/" + nickname + ".zip"));
            for (File photo : folder.listFiles()) {
                FileInputStream fis = new FileInputStream(photo);
                ZipEntry entry1 = new ZipEntry("image" + i + ".jpg");
                i++;
                zout.putNextEntry(entry1);
                // считываем содержимое файла в массив byte
                byte[] buffer = new byte[fis.available()];
                fis.read(buffer);
                // добавляем содержимое к архиву
                zout.write(buffer);
                // закрываем текущую запись для новой записи
                zout.closeEntry();
                fis.close();
            }
            zout.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
