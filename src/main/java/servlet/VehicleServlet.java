package servlet;

import dao.VehicleDAO;
import model.User;
import model.Vehicle;
import util.RequestUtil;
import util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/vehicle")
public class VehicleServlet extends HttpServlet {

    private VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("addForm")) {
            showAddForm(request, response);
        } else if (action.equals("editForm")) {
            showEditForm(request, response);
        } else {
            listVehicles(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("add")) {
            addVehicle(request, response);
        } else if (action.equals("update")) {
            updateVehicle(request, response);
        } else if (action.equals("delete")) {
            deleteVehicle(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/vehicle?action=list");
        }
    }

    private void listVehicles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }

        String keyword = RequestUtil.getText(request, "keyword");
        String type = RequestUtil.getText(request, "type");

        request.setAttribute("vehicles", vehicleDAO.searchVehicles(keyword, type));
        request.setAttribute("keyword", keyword);
        request.setAttribute("type", type);
        request.getRequestDispatcher("/WEB-INF/views/vehicleList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/addVehicle.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(RequestUtil.getInt(request, "vehicleId"));
        if (vehicle == null) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Vehicle not found");
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.getRequestDispatcher("/WEB-INF/views/editVehicle.jsp").forward(request, response);
    }

    private void addVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String type = RequestUtil.getText(request, "type");
        String brand = RequestUtil.getText(request, "brand");
        String model = RequestUtil.getText(request, "model");
        String plateNumber = RequestUtil.getText(request, "plateNumber");
        double dailyRate = RequestUtil.getDouble(request, "dailyRate");
        String status = RequestUtil.getText(request, "status");
        String addView = "/WEB-INF/views/addVehicle.jsp";

        if (brand.isEmpty() || model.isEmpty() || plateNumber.isEmpty()) {
            RequestUtil.forwardWithError(request, response, addView, "Please fill all the fields");
            return;
        }
        if (dailyRate <= 0) {
            RequestUtil.forwardWithError(request, response, addView, "Daily rate must be a number greater than 0");
            return;
        }

        Vehicle vehicle = Vehicle.create(type, 0, brand, model, plateNumber, dailyRate, status);

        if (vehicleDAO.addVehicle(vehicle)) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Vehicle added");
        } else {
            RequestUtil.forwardWithError(request, response, addView, "Could not add the vehicle. The plate number may already exist");
        }
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        int vehicleId = RequestUtil.getInt(request, "vehicleId");
        String type = RequestUtil.getText(request, "type");
        String brand = RequestUtil.getText(request, "brand");
        String model = RequestUtil.getText(request, "model");
        String plateNumber = RequestUtil.getText(request, "plateNumber");
        double dailyRate = RequestUtil.getDouble(request, "dailyRate");
        String status = RequestUtil.getText(request, "status");
        String editView = "/WEB-INF/views/editVehicle.jsp";

        Vehicle existing = vehicleDAO.getVehicleById(vehicleId);
        if (existing == null) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Vehicle not found");
            return;
        }

        if (brand.isEmpty() || model.isEmpty() || plateNumber.isEmpty() || dailyRate <= 0) {
            request.setAttribute("vehicle", existing);
            RequestUtil.forwardWithError(request, response, editView, "Please fill all the fields with valid values");
            return;
        }

        Vehicle vehicle = Vehicle.create(type, vehicleId, brand, model, plateNumber, dailyRate, status);

        if (vehicleDAO.updateVehicle(vehicle)) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Vehicle updated");
        } else {
            request.setAttribute("vehicle", existing);
            RequestUtil.forwardWithError(request, response, editView, "Could not update the vehicle. The plate number may already exist");
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        int vehicleId = RequestUtil.getInt(request, "vehicleId");
        String message;

        if (vehicleDAO.deleteVehicle(vehicleId)) {
            message = "Vehicle deleted";
        } else {
            message = "Cannot delete a vehicle that has bookings";
        }

        RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", message);
    }
}
