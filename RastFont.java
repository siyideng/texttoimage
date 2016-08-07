// RastFont Rasterize chars in a string using given font to grayscale bitmap data.
// Siyi Deng; 08-07-2016;

import java.awt.image.DataBufferByte;
import java.awt.image.BufferedImage;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;

public class RastFont {       
    public static Object[][] rasterize(Font font, String sss) {
        Object[][] r = new Object[sss.length()][3];
        FontRenderContext rendCont = new FontRenderContext(null, true, true);
        for (int i = 0; i < sss.length(); i++) {            
            Rectangle2D bounds = font.getStringBounds(sss.substring(i, i+1), rendCont);
            int w = (int)(bounds.getWidth());
            int h = (int)(bounds.getHeight()*2);
            BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_BYTE_GRAY);
            Graphics g = bi.getGraphics();
            g.setFont(font);
            g.drawString(sss.substring(i, i+1), 0, h*2/3);            
            r[i][0] = (((DataBufferByte)bi.getRaster().getDataBuffer()).getData());
            r[i][1] = w;
            r[i][2] = h;
        }
        return r;
    }
}
