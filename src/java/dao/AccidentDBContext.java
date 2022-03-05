/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Accident;
import model.Contract;

/**
 *
 * @author area1
 */
public class AccidentDBContext extends DBContext {

    public void setAccident(Accident accident) {
        String sql_insert_accident = "INSERT INTO [Accident]\n"
                + "           ([AccidentDate]\n"
                + "           ,[Title]\n"
                + "           ,[CreatedDate]\n"
                + "           ,[Attachment]\n"
                + "           ,[HumanDamage]\n"
                + "           ,[VehicleDamage]\n"
                + "           ,[ContractID])\n"
                + "     VALUES\n"
                + "           (? ,? ,? ,? ,? ,?,?)";
        try {
            PreparedStatement psm_insert_accident = connection.prepareStatement(sql_insert_accident);
            int i = 0;
            psm_insert_accident.setTimestamp(++i, accident.getAccidentDate());
            psm_insert_accident.setString(++i, accident.getTitle());
            psm_insert_accident.setTimestamp(++i, accident.getCreatedDate());
            psm_insert_accident.setString(++i, accident.getAttatchment());
            psm_insert_accident.setString(++i, accident.getHumanDamage());
            psm_insert_accident.setString(++i, accident.getVehicleDamage());
            psm_insert_accident.setInt(++i, accident.getContract().getId());

            psm_insert_accident.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccidentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Accident getLatestAccident(int contractId) {
        try {
            String sql = "SELECT [ID]\n"
                    + "      ,[AccidentDate]\n"
                    + "      ,[Title]\n"
                    + "      ,[CreatedDate]\n"
                    + "      ,[Attachment]\n"
                    + "      ,[HumanDamage]\n"
                    + "      ,[VehicleDamage]\n"
                    + "      ,[ContractID]\n"
                    + "  FROM [Accident]\n"
                    + "  where ContractID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, contractId);
            ResultSet rs = stm.executeQuery();
            Accident accident = null;
            while (rs.next()) {
                if (accident == null) {
                    accident.setId(rs.getInt("ID"));
                    accident.setAccidentDate(rs.getTimestamp("AccidentDate"));
                    accident.setTitle(rs.getString("Title"));
                    accident.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    accident.setAttatchment(rs.getString("Attachment"));
                    accident.setHumanDamage(rs.getString("HumanDamage"));
                    accident.setVehicleDamage(rs.getString("VehicleDamage"));
                    ContractDBContext db = new ContractDBContext();
                    Contract contract = db.staffGetContractDetail(contractId);
                    accident.setContract(contract);
                }
            }
            return accident;
        } catch (SQLException ex) {
            Logger.getLogger(AccidentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
