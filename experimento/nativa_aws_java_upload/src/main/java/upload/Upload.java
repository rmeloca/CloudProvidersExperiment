package upload;

import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Upload {


    public Upload(String bucketName, String nomeArquivo) {
        long iniMilis, fimMilis;
        long tempoMilis;
        InputStream inputStream;

        tempoMilis = 0;

        AmazonS3 s3Client;
        ObjectMetadata objectMetadata;
        PutObjectRequest putObjectRequest;
        PropertiesCredentials propertiesCredentials;

        try {
            propertiesCredentials = new PropertiesCredentials(getClass().getResource("/AwsCredentials.properties").openStream());
            s3Client = new AmazonS3Client(propertiesCredentials);

//            s3Client.createBucket(BUCKET_NAME);

            inputStream = getClass().getResource("/" + nomeArquivo).openStream();
            objectMetadata = new ObjectMetadata();
            objectMetadata.setContentLength(inputStream.available());
            putObjectRequest = new PutObjectRequest(bucketName, nomeArquivo, inputStream, objectMetadata);
            iniMilis = System.currentTimeMillis();
            s3Client.putObject(putObjectRequest);
            fimMilis = System.currentTimeMillis();
            tempoMilis = fimMilis - iniMilis;
            inputStream.close();

            System.out.print(tempoMilis);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        new Upload(args[0], args[1].trim());
    }
}
