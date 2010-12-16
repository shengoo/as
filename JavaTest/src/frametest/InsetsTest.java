package frametest;

import java.awt.Button;
import java.awt.Frame;
import java.awt.GridBagLayout;
import java.awt.Insets;

public class InsetsTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Frame f = new Frame("111111");
		f.setLayout(new GridBagLayout());
		Button b= new Button("222222");
		Insets i=new Insets(200,200,600,600);
		
		f.add(b);
		f.pack();
		f.setVisible(true);
	}

}
