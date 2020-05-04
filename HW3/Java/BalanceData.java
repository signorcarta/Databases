/*
 * Copyright 2019 University of Padua, Italy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Allows to retrieve data useful to draw up the periodic balance sheets of the company,
 * i.e. expenditure on materials, labour (expenditure) and the price of the estimate paid by the customer (income)
 * 
 */
 
public class BalanceData {
  
  /**
   * The JDBC driver to be used
   */
  private static final String DRIVER = "org.postgresql.Driver";
  
  /**
   * The URL of the database to be accessed
   */
  private static final String DATABASE = "jdbc:postgresql://localhost/serramenti";

  /**
   * The username for accessing the database
   */
  private static final String USER = "postgres";

  /**
   * The password for accessing the database
   */
  private static final String PASSWORD = "pwd";
  
  /**
   * The SQL statement to be executed
   */
  private static final String SQL = "SELECT SUM(P.quantity*P.cost) AS totalCostMaterials, SUM(F.workingHours*F.costPerHours) AS totalCostExternalCollaborator, SUM(Q.totalPrice) AS totalIncome FROM Purchased P INNER JOIN JobOrder J ON P.id=J.id INNER JOIN isFulFilledBy F ON F.id = J.id INNER JOIN ExternalCollaborator E ON E.vat = F.vat INNER JOIN Quote Q ON Q.id = J.id WHERE '[2018-01-01,2019-12-31]'::daterange @> J.deliveryDate;";

  public static void main(String[] args) {

    // the connection to the DBMS
    Connection con = null;

    // the statements to be executed
    Statement stmt1 = null;
    Statement stmt2 = null;

    // the results of the statements execution
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    
    // start time of a statement
    long start;

    // end time of a statement
    long end;


    // "data structures" for the data to be read from the database
    
    Float materialCost = null;
    Float collaboratorCost = null;
    Float totalIncome = null;
    Float totalCostMarketing = null;
    
    try {
      // register the JDBC driver
      Class.forName(DRIVER);

      System.out.printf("Driver %s successfully registered.%n", DRIVER);
    } catch (ClassNotFoundException e) {
      System.out.printf(
          "Driver %s not found: %s.%n", DRIVER, e.getMessage());

      // terminate with a generic error code
      System.exit(-1);
    }

    try {

      // connect to the database
      start = System.currentTimeMillis();      
      
      con = DriverManager.getConnection(DATABASE, USER, PASSWORD);                
      
      end = System.currentTimeMillis();

      System.out.printf(
          "Connection to database %s successfully established in %,d milliseconds.%n",
          DATABASE, end-start);

      // create the statement to execute the query 1
      start = System.currentTimeMillis();

      stmt1 = con.createStatement();

      end = System.currentTimeMillis();

      System.out.printf(
          "Statement successfully created in %,d milliseconds.%n",
          end-start);

      // execute the query 1
      start = System.currentTimeMillis();

      rs1 = stmt1.executeQuery(SQL1);

      end = System.currentTimeMillis();

      System.out
          .printf("Query %s successfully executed %,d milliseconds.%n",
              SQL1, end - start);
              
      // create the statement to execute the query 2
      start = System.currentTimeMillis();

      stmt2 = con.createStatement();

      end = System.currentTimeMillis();

      System.out.printf(
          "Statement successfully created in %,d milliseconds.%n",
          end-start);

      // execute the query 2
      start = System.currentTimeMillis();

      rs2 = stmt2.executeQuery(SQL2);

      end = System.currentTimeMillis();

      System.out
          .printf("Query %s successfully executed %,d milliseconds.%n",
              SQL2, end - start);

      System.out
          .printf("Query results:%n");

      // cycle on the query 1 results and print them
      while (rs1.next()) {
        
        materialCost = rs1.getInt("totalCostMaterials");
        
        collaboratorCost = rs1.getInt("totalCostExternalCollaborator");
        
        totalIncome = rs1.getInt("totalIncome");

        System.out.printf("Total Material Cost %i,Total External Collaborator Cost %i, Total Income %i%n", 
            materialCost, collaboratorCost, totalIncome);

      }
      
      // cycle on the query 2 results and print them
      while (rs2.next()) {
        
        totalCostMarketing = rs2.getInt("totalCostMarketing");

        System.out.printf("Total Marketing Cost %i%n", 
            totalCostMarketing);

      }
      
    } catch (SQLException e) {
      System.out.printf("Database access error:%n");

      // cycle in the exception chain
      while (e != null) {
        System.out.printf("- Message: %s%n", e.getMessage());
        System.out.printf("- SQL status code: %s%n", e.getSQLState());
        System.out.printf("- SQL error code: %s%n", e.getErrorCode());
        System.out.printf("%n");
        e = e.getNextException();
      }
    } finally {
      try { 
        
        // close the used resources
        if (rs1 != null) {
          
          start = System.currentTimeMillis();
          
          rs1.close();
          
          end = System.currentTimeMillis();
          
          System.out
          .printf("Result set successfully closed in %,d milliseconds.%n",
              end-start);
        }
        
        if (stmt1 != null) {
          
          start = System.currentTimeMillis();
          
          stmt1.close();
          
          end = System.currentTimeMillis();
          
          System.out
          .printf("Statement successfully closed in %,d milliseconds.%n",
              end-start);
        }
        
        if (rs2 != null) {
          
          start = System.currentTimeMillis();
          
          rs2.close();
          
          end = System.currentTimeMillis();
          
          System.out
          .printf("Result set successfully closed in %,d milliseconds.%n",
              end-start);
        }
        
        if (stmt2 != null) {
          
          start = System.currentTimeMillis();
          
          stmt2.close();
          
          end = System.currentTimeMillis();
          
          System.out
          .printf("Statement successfully closed in %,d milliseconds.%n",
              end-start);
        }
        
        if (con != null) {
          
          start = System.currentTimeMillis();
          
          con.close();
          
          end = System.currentTimeMillis();
          
          System.out
          .printf("Connection successfully closed in %,d milliseconds.%n",
              end-start);
        }
        
        System.out.printf("Resources successfully released.%n");
        
      } catch (SQLException e) {
        System.out.printf("Error while releasing resources:%n");

        // cycle in the exception chain
        while (e != null) {
          System.out.printf("- Message: %s%n", e.getMessage());
          System.out.printf("- SQL status code: %s%n", e.getSQLState());
          System.out.printf("- SQL error code: %s%n", e.getErrorCode());
          System.out.printf("%n");
          e = e.getNextException();
        }

      } finally {

        // release resources to the garbage collector
        rs1 = null;
        stmt1 = null;
        rs2 = null;
        stmt2 = null;
        con = null;

        System.out.printf("Resources released to the garbage collector.%n");
      }
    }
    
    System.out.printf("Program end.%n");
    
  }
}
