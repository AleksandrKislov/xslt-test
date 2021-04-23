import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class TestTransformer {
    public static void main(String[] args){
        try{
            TransformerFactory tff = TransformerFactory.newInstance();
            Transformer tf = tff.newTransformer(new StreamSource(new File("src//test.xslt")));
            StreamSource ss = new StreamSource(new File("src//XSLT_Trainee_Test_Problem.xml"));
            StreamResult sr = new StreamResult(new File("src//XSLT_Trainee_Test_Problem.html"));
            tf.transform(ss,sr);
            System.out.println("Done");
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}
