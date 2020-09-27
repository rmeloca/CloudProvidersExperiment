package upload;

import com.microsoft.azure.storage.CloudStorageAccount;
import com.microsoft.azure.storage.StorageCredentials;
import com.microsoft.azure.storage.StorageCredentialsAccountAndKey;
import com.microsoft.azure.storage.StorageException;
import com.microsoft.azure.storage.blob.CloudBlobClient;
import com.microsoft.azure.storage.blob.CloudBlobContainer;
import com.microsoft.azure.storage.blob.CloudBlockBlob;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Upload {

    private static final String STORAGE_ACC_NAME = "experimento";
    private static final String SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg==";

    public Upload(String containerName, String nomeArquivo) {
        long iniMilis, fimMilis;
        long tempoMilis;
        InputStream inputStream;

        tempoMilis = 0;

        StorageCredentials storageCredentials;
        CloudStorageAccount storageAccount;
        CloudBlobClient blobClient;
        CloudBlobContainer container;
        CloudBlockBlob blob;

        try {
            storageCredentials = new StorageCredentialsAccountAndKey(STORAGE_ACC_NAME, SECRET_KEY);
            storageAccount = new CloudStorageAccount(storageCredentials);
            blobClient = storageAccount.createCloudBlobClient();
            container = blobClient.getContainerReference(containerName);

// create a container in the default location
            container.createIfNotExists();

            inputStream = getClass().getResource("/" + nomeArquivo).openStream();
            blob = container.getBlockBlobReference(nomeArquivo);
            iniMilis = System.currentTimeMillis();
            blob.upload(inputStream, inputStream.available());
            fimMilis = System.currentTimeMillis();
            tempoMilis = fimMilis - iniMilis;
            inputStream.close();

            System.out.print(tempoMilis);
        } catch (URISyntaxException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (StorageException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        new Upload(args[0], args[1].trim());
    }
}
