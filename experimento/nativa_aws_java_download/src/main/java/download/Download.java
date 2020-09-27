/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package download;

import com.amazonaws.auth.PropertiesCredentials;
import com.google.common.io.ByteStreams;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author romulo
 */
public class Download {


    public Download(String bucketName, String nomeArquivo) {
        long iniMilis, fimMilis;
        long tempoMilis;
        String nomeArquivoDownload;
        InputStream inputStream;
        OutputStream outputStream;

        tempoMilis = 0;
        nomeArquivoDownload = "download";

        AmazonS3 s3Client;
        GetObjectRequest getObjectRequest;
        S3Object object;
        PropertiesCredentials propertiesCredentials;

        try {
            propertiesCredentials = new PropertiesCredentials(getClass().getResource("/AwsCredentials.properties").openStream());
            s3Client = new AmazonS3Client(propertiesCredentials);

            outputStream = new FileOutputStream(nomeArquivoDownload);
            getObjectRequest = new GetObjectRequest(bucketName, nomeArquivo);
            iniMilis = System.currentTimeMillis();
            object = s3Client.getObject(getObjectRequest);
            inputStream = object.getObjectContent();
            ByteStreams.copy(inputStream, outputStream);
            fimMilis = System.currentTimeMillis();
            tempoMilis = fimMilis - iniMilis;
            inputStream.close();
            outputStream.close();

            System.out.print(tempoMilis);
        } catch (IOException ex) {
            Logger.getLogger(Download.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        new Download(args[0], args[1].trim());
    }
}
