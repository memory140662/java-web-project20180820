package tw.com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdk.nashorn.internal.ir.debug.JSONWriter;
import jdk.nashorn.internal.parser.JSONParser;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONBuilder;
import net.sf.json.util.JSONStringer;
import tw.com.bean.Item;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet("/")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Collection<Item> items = new ArrayList<>();
		items.add(new Item(1L, "Leo", "Test1"));
		items.add(new Item(2L, "Tom", "Hello"));
		items.add(new Item(3L, "Bingo", "It's a test."));
		String json = JSONArray.fromObject(items).toString();
		request.setAttribute("items", items);
		request.setAttribute("jsonItems", json);
		request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONArray ja = JSONArray.fromObject(request.getParameter("items"));
		Collection<Item> items = JSONArray.toCollection(ja, Item.class);
		request.setAttribute("items", items);
		request.setAttribute("jsonItems", request.getParameter("items"));
		request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
	}

}
