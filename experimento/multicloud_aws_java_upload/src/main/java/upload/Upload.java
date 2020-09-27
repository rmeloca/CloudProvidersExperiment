package upload;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jclouds.ContextBuilder;
import org.jclouds.blobstore.BlobStore;
import org.jclouds.blobstore.BlobStoreContext;
import org.jclouds.blobstore.domain.Blob;

/**
 * Hello world!
 *
 */
public class Upload {

    private static final String ACCESS_KEY = "AKIAJ5TVZPWOSYKRW4FQ";
    private static final String SECRET_KEY = "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";

    public Upload(String bucketName, String nomeArquivo) {
        Blob blob;
        long tempoMilis;
        long iniMilis, fimMilis;
        String provider;
        InputStream inputStream;

        tempoMilis = 0;
        provider = "aws-s3";

// get a context with amazon that offers the portable BlobStore API
        ContextBuilder contextBuilder = ContextBuilder.newBuilder(provider).credentials(ACCESS_KEY, SECRET_KEY);

        BlobStoreContext context = (BlobStoreContext) contextBuilder.buildView(BlobStoreContext.class);

        BlobStore blobStore = context.getBlobStore();

// create a container in the default location
//        blobStore.createContainerInLocation(null, BUCKET_NAME);
        try {
// add blob
            inputStream = getClass().getResource("/" + nomeArquivo).openStream();
            blob = blobStore.blobBuilder(nomeArquivo)
                    .payload(inputStream)
                    .contentLength(inputStream.available())
                    .build();

            iniMilis = System.currentTimeMillis();
            blobStore.putBlob(bucketName, blob);
            fimMilis = System.currentTimeMillis();
            tempoMilis = fimMilis - iniMilis;
            inputStream.close();

            System.out.print(tempoMilis);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
        }

// Close connection
        context.close();
    }

    public static void main(String[] args) {
        new Upload(args[0], args[1].trim());
    }
}
