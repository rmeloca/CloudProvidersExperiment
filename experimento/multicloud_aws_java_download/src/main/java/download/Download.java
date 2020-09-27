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

    private static final String ACCESS_KEY = "AKIAJ5TVZPWOSYKRW4FQ";
    private static final String SECRET_KEY = "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";

    public Download(String bucketName, String nomeArquivo) {
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
        provider = "aws-s3";

        // get a context with amazon that offers the portable BlobStore API
        ContextBuilder contextBuilder = ContextBuilder.newBuilder(provider).credentials(ACCESS_KEY, SECRET_KEY);

        BlobStoreContext context = (BlobStoreContext) contextBuilder.buildView(BlobStoreContext.class);

        BlobStore blobStore = context.getBlobStore();

        try {
            outputStream = new FileOutputStream(nomeArquivoDownload);
            iniMilis = System.currentTimeMillis();
            blob = blobStore.getBlob(bucketName, nomeArquivo);
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
