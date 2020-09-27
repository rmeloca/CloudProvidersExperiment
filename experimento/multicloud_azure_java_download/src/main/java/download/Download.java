/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package download;

import com.google.common.io.ByteStreams;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jclouds.ContextBuilder;
import org.jclouds.blobstore.domain.Blob;
import org.jclouds.blobstore.BlobStore;
import org.jclouds.blobstore.BlobStoreContext;
import org.jclouds.io.Payload;

/**
 *
 * @author romulo
 */
public class Download {

    private static final String STORAGE_ACC_NAME = "experimento";
    private static final String SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg==";

    public Download(String containerName, String nomeArquivo) {
        Blob blob;
        long tempoMilis;
        long iniMilis, fimMilis;
        String nomeArquivoDownload;
        String provider;
        Payload payload;
        InputStream inputStream;
        OutputStream outputStream;

        tempoMilis = 0;
        nomeArquivoDownload = "download";
        provider = "azureblob";

        // get a context with amazon that offers the portable BlobStore API
        ContextBuilder contextBuilder = ContextBuilder.newBuilder(provider).credentials(STORAGE_ACC_NAME, SECRET_KEY);

        BlobStoreContext context = (BlobStoreContext) contextBuilder.buildView(BlobStoreContext.class);

        BlobStore blobStore = context.getBlobStore();

        try {
            outputStream = new FileOutputStream(nomeArquivoDownload);
            iniMilis = System.currentTimeMillis();
            blob = blobStore.getBlob(containerName, nomeArquivo);
            payload = blob.getPayload();
            inputStream = payload.openStream();
            ByteStreams.copy(inputStream, outputStream);
            payload.release();
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
