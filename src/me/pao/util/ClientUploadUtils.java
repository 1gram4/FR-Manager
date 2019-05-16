package me.pao.util;

import okhttp3.*;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 *
 */
public class ClientUploadUtils {

    public static ResponseBody upload(String url, String filePath, String fileName) throws Exception {
        OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("file", fileName,
                        RequestBody.create(MediaType.parse("multipart/form-data"), new File(filePath)))
                .build();

        Request request = new Request.Builder()
                .header("Authorization", "Client-ID " + UUID.randomUUID())
                .url(url)
                .post(requestBody)
                .build();

        Response response = client.newCall(request).execute();
        if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

        return response.body();
    }

/*
    public static void main(String[] args) throws IOException {
        for(int i=1;i<=200;i++){
            try {
                String fileName = "16122070_"+i+".png";
                String filePath = "F:\\userimg\\16122070\\16122070_"+i+".png";
                String url = "http://172.20.10.9:8012/";
                System.out.println(upload(url, filePath, fileName).string());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
    */

}
