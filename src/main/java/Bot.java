import org.apache.commons.io.FileUtils;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendDocument;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.ReplyKeyboardMarkup;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.KeyboardButton;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.KeyboardRow;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

// TODO: 20.05.2020 Сделать скачку всех фото из каруселей
// TODO: 20.05.2020 Придумать быстрый способ скачки всех фото в открытом виде (возможно открытие кучи вкладок)
public class Bot extends TelegramLongPollingBot {
    /**
     * Метод для приема сообщений.
     *
     * @param update Содержит сообщение от пользователя.
     */
    @Override
    public void onUpdateReceived(Update update) {
        String message = update.getMessage().getText();
        String chatId = update.getMessage().getChatId().toString();
        if (message.equals("Start")) {
            sendMsg(chatId, "Hello, i can download photo from instagram for you");
        } else if (message.equals("Download one photo")) {
            sendMsg(chatId, "Just send me URL of photo");
        } else if (message.equals("Download all (take a time)")) {
            sendMsg(chatId,
                    "I need nickname of account " +
                            "\nI can download it only if account is public " +
                            "\nAnd i'm sorry, but I can't download all the photos from the carousel yet :(");
        } else {
            //проверяем, что отправили, если это не ссылка, то ищем аккаунт, качаем фото
            //если ссылка, проверяем инстаграмм ли это
            try {
                String nickname = update.getMessage().getText();
                String[] s = nickname.split("/");
                if (nickname.split("/").length <= 1) {
                    Browser browser = new Browser(nickname);
                    MakeZip makeZip = new MakeZip(nickname);
                    if (browser.getPhotos().size() != 0) {
                        makeZip.makeZip();
                        SendDocument sendDocument = new SendDocument();
                        sendDocument.setChatId(chatId);
                        sendDocument.setDocument(new File("src/main/resources/photos/" + nickname + "/" + nickname + ".zip"));
                        execute(sendDocument);
                        try {
                            FileUtils.deleteDirectory(new File("src/main/resources/photos/" + nickname));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    } else {
                        sendMsg(chatId, "Ooops, closed or nothing to download");
                    }
                } else if (s[2].equals("www.instagram.com")) {
                    System.out.println("i'm here");
                    DownloadOnePhoto downloadOnePhoto = new DownloadOnePhoto(nickname);
                    downloadOnePhoto.download();
                    SendDocument sendDocument = new SendDocument();
                    sendDocument.setChatId(chatId);
                    sendDocument.setDocument(new File("src/main/resources/photos/" + s[4] + "/image.jpg"));
                    execute(sendDocument);
                    try {
                        FileUtils.deleteDirectory(new File("src/main/resources/photos/" + s[4]));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }

            } catch (InterruptedException | TelegramApiException e) {
                e.printStackTrace();
            }

        }
    }

    /**
     * Метод для настройки сообщения и его отправки.
     *
     * @param chatId id чата
     * @param s      Строка, которую необходимот отправить в качестве сообщения.
     */
    public synchronized void sendMsg(String chatId, String s) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.enableMarkdown(true);
        sendMessage.setChatId(chatId);
        sendMessage.setText(s);
        setButtons(sendMessage);
        try {
            execute(sendMessage);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }

    /**
     * Метод возвращает имя бота, указанное при регистрации.
     *
     * @return имя бота
     */
    @Override
    public String getBotUsername() {
        return "TakeInstaPhotoBot";
    }

    /**
     * Метод возвращает token бота для связи с сервером Telegram
     *
     * @return token для бота
     */
    @Override
    public String getBotToken() {
        String token = "";
        try {
            token = new BufferedReader(new InputStreamReader(new FileInputStream(new File("D:/Project/TelegramInstaBot/src/main/resources/token.txt")))).readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return token;
    }

    public synchronized void setButtons(SendMessage sendMessage) {
        // Создаем клавиуатуру
        ReplyKeyboardMarkup replyKeyboardMarkup = new ReplyKeyboardMarkup();
        sendMessage.setReplyMarkup(replyKeyboardMarkup);
        replyKeyboardMarkup.setSelective(true);
        replyKeyboardMarkup.setResizeKeyboard(true);
        replyKeyboardMarkup.setOneTimeKeyboard(false);

        // Создаем список строк клавиатуры
        List<KeyboardRow> keyboard = new ArrayList<KeyboardRow>();

        // Первая строчка клавиатуры
        KeyboardRow keyboardFirstRow = new KeyboardRow();
        // Добавляем кнопки в первую строчку клавиатуры
        keyboardFirstRow.add(new KeyboardButton("Download one photo"));

        // Вторая строчка клавиатуры
        KeyboardRow keyboardSecondRow = new KeyboardRow();
        // Добавляем кнопки во вторую строчку клавиатуры
        keyboardSecondRow.add(new KeyboardButton("Download all (take a time)"));

        // Добавляем все строчки клавиатуры в список
        keyboard.add(keyboardFirstRow);
        keyboard.add(keyboardSecondRow);
        // и устанваливаем этот список нашей клавиатуре
        replyKeyboardMarkup.setKeyboard(keyboard);
    }
}

