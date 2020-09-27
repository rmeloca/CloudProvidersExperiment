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

    private static final String STORAGE_ACC_NAME = "experimento";
    private static final String SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg==";

    public Upload(String containerName, String nomeArquivo) {
        Blob blob;
        long tempoMilis;
        long iniMilis, fimMilis;
        String provider;
        InputStream inputStream;

        tempoMilis = 0;
        provider = "azureblob";

// get a context with azure
        ContextBuilder contextBuilder = ContextBuilder.newBuilder(provider).credentials(STORAGE_ACC_NAME, SECRET_KEY);

        BlobStoreContext context = (BlobStoreContext) contextBuilder.buildView(BlobStoreContext.class);

        BlobStore blobStore = context.getBlobStore();

// create a container in the default location
//        blobStore.createContainerInLocation(null, CONTAINER_NAME);
        try {
// add blob
            inputStream = getClass().getResource("/" + nomeArquivo).openStream();

            blob = blobStore.blobBuilder(nomeArquivo)
                    .payload(inputStream)
                    .contentLength(inputStream.available())
                    .build();

            iniMilis = System.currentTimeMillis();
            blobStore.putBlob(containerName, blob);
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
