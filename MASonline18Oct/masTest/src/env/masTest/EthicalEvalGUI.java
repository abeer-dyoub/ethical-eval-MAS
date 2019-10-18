// CArtAgO artifact code for project masTest

package masTest;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JLabel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import cartago.*;
import cartago.tools.GUIArtifact;

public class EthicalEvalGUI extends GUIArtifact {
	private Eval eval;
	public void setup() {
		eval=new Eval();
		//linkActionEventToOp(emp.send2, "send");
		defineObsProperty("textVal", "");
		eval.setVisible(true);
	}


	@OPERATION void setValue1(String txtVal) {
		eval.setText("unethical("+txtVal+")");
		
		getObsProperty("textVal").updateValue(getValue());
	}
	@OPERATION void setValue2(String txtVal) {
		eval.setText("ethical("+txtVal+")");
		getObsProperty("textVal").updateValue(getValue());
	}

private String getValue() {
	return eval.getText();
}


static class Eval extends JFrame {
	static String username2;

	private JPanel contentPane;

	/**
	 * Launch the application.
	 */


	/**
	 * Create the frame.
	 */
	public Eval() {
		setTitle("Ethical Evaluation");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 140);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		
	    text = new JTextField();
		text.setBounds(17, 42, 400, 35);
		contentPane.add(text);
		
		

		
		label = new JLabel("Evaluation");
		label.setBounds(15, 17, 177, 14);
		contentPane.add(label);
	}


	public void setText(String s) {
		text.setText(s);
	}
	
	public String getText() {
		return text.getText();
	}
	private  javax.swing.JLabel label;

	public  static javax.swing.JTextField text;

}
}


