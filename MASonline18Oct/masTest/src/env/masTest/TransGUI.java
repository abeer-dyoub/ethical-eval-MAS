// CArtAgO artifact code for project masTest

package masTest;

import cartago.*;
import cartago.tools.GUIArtifact;

import javax.swing.border.EmptyBorder;

//import javax.swing.JButton;
//import javax.swing.JLabel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.*;
//import java.awt.event.*;
import javax.swing.*;
import se.sics.prologbeans.*;
import se.sics.prologbeans.PrologSession;
import se.sics.prologbeans.Bindings;
import se.sics.prologbeans.PBTerm;
import se.sics.prologbeans.QueryAnswer;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class TransGUI extends GUIArtifact {
	public EvaluateGUI eval;
	public void setup(){

		      try {
				eval=new EvaluateGUI();
			} catch (IOException e) {
				e.printStackTrace();
			}
		    
		linkKeyStrokeToOp(eval.text,"ENTER","updateText");
		defineObsProperty("textVal1", "");
		defineObsProperty("textVal2", "");
		eval.setVisible(true);
	 }
		
	@INTERNAL_OPERATION void updateText(ActionEvent ev) {
		getObsProperty("textVal2").updateValue(getValue2());
	
	}
	@OPERATION void printValue(String s) {
		ObsProperty prop = this.getObsProperty("textVal");
		System.out.println(s+":"+prop.stringValue());
	}
	@OPERATION void setValue1(String txtVal) {
		eval.setText1(txtVal);
		getObsProperty("textVal1").updateValue(getValue1());
	}

	@OPERATION void setValue2(String txtVal) {
		eval.setText2(txtVal);
		getObsProperty("textVal2").updateValue(getValue2());
	}
	
	@OPERATION void translatex(String s) {
		String message;
		
        try {
          Bindings bindings = new Bindings().bind("E", s);
          QueryAnswer answer =
    	eval.session.executeQuery("evaluate(E,R)", bindings);
          PBTerm result = answer.getValue("R");
          if (result != null) {
        	  message=result.toString();
    	eval.text.setText(message);

          } else {
            message = "Empty: " + answer.getError() + '\n';
    	eval.text.setText(message);
          }
        } catch (Exception e) {
          message = "Error when querying Prolog Server: " + e.getMessage() + '\n';
         eval.text.setText(message);
          e.printStackTrace();
        }
  
        System.err.println("Log: " + message);

        getObsProperty("textVal2").updateValue(getValue2());
      
	}
	
private String getValue1() {
	return eval.getText1();
}

private String getValue2() {
	return eval.getText2();
}


class SyncObject {
    boolean sicstus_ready = false;
}

class EvaluateGUI extends JFrame {
	
	private JPanel contentPane;
	private  javax.swing.JLabel label1;
	private  javax.swing.JLabel label2;
  public JTextField text;
  public JTextField input;

  public PrologSession session = new PrologSession();
  public int timeout = Integer.getInteger("se.sics.prologbeans.timeout", 0).intValue();

  public SyncObject syncObj;

  public EvaluateGUI() throws java.io.IOException
  {
  
    setTitle("Evaluate");
	setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	setBounds(100, 100, 450, 200);
	contentPane = new JPanel();
	contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
	setContentPane(contentPane);
	contentPane.setLayout(null);
	
	label1 = new JLabel("Answer");
	label1.setBounds(17, 15, 190, 14);
	contentPane.add(label1);
	    input = new JTextField();
	input.setBounds(17, 42, 400, 40);

	contentPane.add(input);
		label2 = new JLabel("Translation");
	label2.setBounds(17, 100, 190, 14);
	contentPane.add(label2);
	text = new JTextField();
	text.setBounds(17, 120, 400, 40);
	contentPane.add(text);

	session.connect();
    }


  void batch_queries() {
      final Runnable calculate = new Runnable() {
	      public void run() {
		  input.requestFocus();
	      }		    
	  };

      new Thread() {
	  public void run() {
	      try {
		  List ql = Arrays.asList(new String[] {"4+6", "11-5", "3*7", "9/3"});
		  for (Iterator i = ql.iterator(); i.hasNext(); ) {
		      String q = (String)i.next();
		      input.setText(q);
		      SwingUtilities.invokeAndWait(calculate);
		  }
		  session.executeQuery("shutdown");
		  session.disconnect();
		  System.exit(0);
	      } catch (Exception ex) {
		  text.setText("Error: " +
			      ex.getMessage() + '\n');
		  ex.printStackTrace();
	      }
	  }
      }.start();
  } 


public String getText1() {
	return input.getText();
}
public String getText2() {
	return text.getText();
}

public void setText1(String s) {
	 input.setText(s);
}
public void setText2(String s) {
	 text.setText(s);
}
}
}
