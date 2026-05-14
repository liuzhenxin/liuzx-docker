import org.liuzx.nas.ImageSM4Util;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;

public class Sm4CbcRunner {

	private static final byte[] TEST_IV = "0123456789ABCDEF".getBytes(StandardCharsets.UTF_8);

	private static final byte[] PLAINTEXT = "LCloud NAS SM4 CBC docker test data".getBytes(StandardCharsets.UTF_8);

	public static void main(String[] args) throws Exception {
		Path hsmConfig = Path.of("/app/sdhsm.ini");
		System.out.println("HSM config: " + hsmConfig + " exists=" + Files.isRegularFile(hsmConfig));
		printHsmEndpoint(hsmConfig);
		System.out.println("Testing SM4 CBC with HSM key index from ImageSM4Util");

		try {
			byte[] encrypted = ImageSM4Util.encSm4Cbc(PLAINTEXT, TEST_IV);
			byte[] decrypted = ImageSM4Util.decSm4Cbc(encrypted, TEST_IV);
			require(!Arrays.equals(PLAINTEXT, encrypted), "ciphertext equals plaintext");
			require(Arrays.equals(PLAINTEXT, decrypted), "byte round trip mismatch");
			System.out.println("SM4 CBC byte round trip OK");
			System.out.println("plain.length=" + PLAINTEXT.length + ", encrypted.length=" + encrypted.length);

			Path tempDir = Files.createTempDirectory("sm4cbc-");
			Path plainFile = tempDir.resolve("plain.txt");
			Path encryptedFile = tempDir.resolve("plain.txt.enc");
			Path decryptedFile = tempDir.resolve("plain.txt.dec");
			Files.write(plainFile, PLAINTEXT);

			ImageSM4Util.encSm4CbcFile(plainFile.toString(), encryptedFile.toString(), TEST_IV);
			ImageSM4Util.decSm4CbcFile(encryptedFile.toString(), decryptedFile.toString(), TEST_IV);
			byte[] fileEncrypted = Files.readAllBytes(encryptedFile);
			byte[] fileDecrypted = Files.readAllBytes(decryptedFile);
			require(!Arrays.equals(PLAINTEXT, fileEncrypted), "encrypted file equals plaintext file");
			require(Arrays.equals(PLAINTEXT, fileDecrypted), "file round trip mismatch");
			System.out.println("SM4 CBC file round trip OK");
			System.out.println("tempDir=" + tempDir);
		}
		catch (Throwable ex) {
			System.err.println("SM4 CBC test FAILED: " + rootMessage(ex));
			throw ex;
		}
	}

	private static void printHsmEndpoint(Path hsmConfig) throws Exception {
		if (!Files.isRegularFile(hsmConfig)) {
			return;
		}
		for (String line : Files.readAllLines(hsmConfig, StandardCharsets.UTF_8)) {
			String normalized = line.split("#", 2)[0].trim();
			if (normalized.startsWith("IP") || normalized.startsWith("PORT") || normalized.startsWith("CONNTIMEOUT")
					|| normalized.startsWith("RWTIMEOUT")) {
				System.out.println(normalized);
			}
		}
	}

	private static void require(boolean condition, String message) {
		if (!condition) {
			throw new IllegalStateException(message);
		}
	}

	private static String rootMessage(Throwable ex) {
		Throwable current = ex;
		while (current.getCause() != null) {
			current = current.getCause();
		}
		return current.getClass().getSimpleName() + ": " + current.getMessage();
	}

}
