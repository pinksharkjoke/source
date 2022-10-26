import java.io.File;

public class pathtest {
	public static void main(String[] args) {
		File file = new File("");
        System.out.println("현재 프로젝트의 경로 : "+file.getAbsoluteFile());


	}
	
}
