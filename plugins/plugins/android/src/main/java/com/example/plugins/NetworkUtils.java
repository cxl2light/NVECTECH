package com.example.plugins;

import android.util.Log;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.net.MalformedURLException;
import java.io.IOException;


public class NetworkUtils {

    public static String etworkUtils(String urls) {
        String result="";
        try {
            URL url=new URL(urls);

            HttpURLConnection connection= (HttpURLConnection) url.openConnection();

            connection.setDoOutput(false);
            connection.setDoInput(true);
            connection.setRequestMethod("GET");
            connection.setUseCaches(true);
            connection.setInstanceFollowRedirects(true);
            connection.setConnectTimeout(3000);

            connection.connect();

            int code = connection.getResponseCode();

            if (code==200){
                BufferedReader br=new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String line="";
                while ((line=br.readLine())!=null){
                    result += line;
                }
                br.close();
            }
            connection.disconnect();
            Log.i("net data",result);

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

}