package practice;

import javax.swing.JFrame;

public class DustDateFrame extends JFrame{
	
	
	
	public DustDateFrame() {
		initData();
		setInitLayout();
		addEventListener();
	}

	private void initData() {
		
	}

	private void setInitLayout() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setTitle(" 미세먼지 경보 발령 현황 ");
		setSize(500, 800);
		setLayout(null);
		setResizable(false);
		setLocationRelativeTo(null);
		setVisible(true);
	}

	private void addEventListener() {
		
	}
	
	public static void main(String[] args) {
		new DustDateFrame();
	}
	
}
