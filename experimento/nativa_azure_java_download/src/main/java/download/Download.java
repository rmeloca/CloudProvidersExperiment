/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package download;

import com.microsoft.azure.storage.CloudStorageAccount;
import com.microsoft.azure.storage.StorageCredentials;
import com.microsoft.azure.storage.StorageCredentialsAccountAndKey;
import com.microsoft.azure.storage.StorageException;
import com.microsoft.azure.storage.blob.CloudBlobClient;
import com.microsoft.azure.storage.blob.CloudBlobContainer;
import com.microsoft.azure.storage.blob.CloudBlockBlob;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author romulo
 */
public class Download {

    private static final String STORAGE_ACC_NAME = "experimento";
    private static final String SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg==";

    public Download(String containerName, String nomeArquivo) {
        long tempoMilis;
        long iniMilis, fimMilis;
        String nomeArquivoDownload;
        OutputStream outputStream;

        tempoMilis = 0;
        nomeArquivoDownload = "download";

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

            outputStream = new FileOutputStream(nomeArquivoDownload);
            blob = container.getBlockBlobReference(nomeArquivo);
            iniMilis = System.currentTimeMillis();
            blob.download(outputStream);
            fimMilis = System.currentTimeMillis();
            tempoMilis = fimMilis - iniMilis;
            outputStream.close();

            System.out.print(tempoMilis);
        } catch (IOException ex) {
            Logger.getLogger(Download.class.getName()).log(Level.SEVERE, null, ex);
        } catch (URISyntaxException ex) {
            Logger.getLogger(Download.class.getName()).log(Level.SEVERE, null, ex);
        } catch (StorageException ex) {
            Logger.getLogger(Download.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        new Download(args[0], args[1].trim());
    }
}
