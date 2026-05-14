import org.liuzx.nas.ImageSM4Util;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

public class BatchSm4CbcDecryptRunner {

	private static final Path DEFAULT_INPUT_DIR = Path.of("/Users/liuzhenxin/20240427-enc");

	private static final Path DEFAULT_OUTPUT_DIR = Path.of("/Users/liuzhenxin/20240427-dec-test");

	private static final byte[] DEFAULT_IV = "LCloud-NAS-IV123".getBytes(StandardCharsets.UTF_8);

	public static void main(String[] args) throws Exception {
		Path inputDir = args.length > 0 ? Path.of(args[0]) : DEFAULT_INPUT_DIR;
		Path outputDir = args.length > 1 ? Path.of(args[1]) : DEFAULT_OUTPUT_DIR;
		byte[] iv = args.length > 2 ? args[2].getBytes(StandardCharsets.UTF_8) : DEFAULT_IV;

		if (iv.length != 16) {
			throw new IllegalArgumentException("IV must be 16 bytes, actual=" + iv.length);
		}
		if (!Files.isDirectory(inputDir)) {
			throw new IllegalArgumentException("Input directory does not exist: " + inputDir);
		}
		if (inputDir.toAbsolutePath().normalize().equals(outputDir.toAbsolutePath().normalize())) {
			throw new IllegalArgumentException("Output directory must not equal input directory: " + outputDir);
		}

		Files.createDirectories(outputDir);
		List<Path> files = listFiles(inputDir);

		System.out.println("NAS SM4 CBC decrypt test");
		System.out.println("inputDir=" + inputDir);
		System.out.println("outputDir=" + outputDir);
		System.out.println("files=" + files.size());

		int success = 0;
		int failed = 0;
		for (Path source : files) {
			Path relative = inputDir.relativize(source);
			Path target = outputDir.resolve(relative);
			try {
				Files.createDirectories(target.getParent());
				ImageSM4Util.decSm4CbcFile(source.toString(), target.toString(), iv);
				success++;
				System.out.println("OK  " + relative + " -> " + target);
			}
			catch (Throwable ex) {
				failed++;
				System.err.println("ERR " + relative + " : " + rootMessage(ex));
			}
		}

		System.out.println("decrypt summary: success=" + success + ", failed=" + failed);
		if (failed > 0) {
			System.exit(2);
		}
	}

	private static List<Path> listFiles(Path inputDir) throws Exception {
		try (Stream<Path> stream = Files.walk(inputDir)) {
			return stream.filter(Files::isRegularFile).sorted(Comparator.naturalOrder()).toList();
		}
		catch (UnsupportedOperationException ex) {
			List<Path> files = new ArrayList<>();
			try (Stream<Path> stream = Files.walk(inputDir)) {
				stream.filter(Files::isRegularFile).sorted(Comparator.naturalOrder()).forEach(files::add);
			}
			return files;
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
