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
 * Allows to retrieve contact information to carry out corporate marketing campaigns aimed at a group of customers
 * 
 */
 
public class MarketingGroup {
	
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
	private static final String SQL = "SELECT DISTINCT C.Name AS name, C.Surname AS surname, C.Address AS address, C.telephone AS telephone, C.email AS email FROM Customer C INNER JOIN Quote Q ON C.telephone = Q.telephone INNER JOIN  JobOrder J ON Q.id = J.id INNER JOIN Purchased P ON P.id = J.id INNER JOIN Material M ON M.productCode = P.productCode WHERE lower(M.Name) LIKE ‘%window%’ OR lower(M.Name) = ‘%door%’;";
	
	public static void main(String[] args) {

		// the connection to the DBMS
		Connection con = null;

		// the statement to be executed
		Statement stmt = null;

		// the results of the statement execution
		ResultSet rs = null;
		
		// start time of a statement
		long start;

		// end time of a statement
		long end;


		// "data structures" for the data to be read from the database
		
		// the data recover
		String name = null;
		String surname = null;
		String address = null;
		String telephone = null;
		String email = null;
		
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

			// create the statement to execute the query
			start = System.currentTimeMillis();

			stmt = con.createStatement();

			end = System.currentTimeMillis();

			System.out.printf(
					"Statement successfully created in %,d milliseconds.%n",
					end-start);

			// execute the query
			start = System.currentTimeMillis();

			rs = stmt.executeQuery(SQL);

			end = System.currentTimeMillis();

			System.out
					.printf("Query %s successfully executed %,d milliseconds.%n",
							SQL, end - start);

			System.out
					.printf("Query results:%n");

			// cycle on the query results and print them
			while (rs.next()) {
				
				name = rs.getString("name");
				
				surname = rs.getString("surname");
				
				address = rs.getString("address");
				
				telephone = rs.getString("telephone");
				
				email = rs.getString("email");

				System.out.printf("- %s, %s, %s, %s, %s%n", 
						name, surname, address, telephone, email);

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
				if (rs != null) {
					
					start = System.currentTimeMillis();
					
					rs.close();
					
					end = System.currentTimeMillis();
					
					System.out
					.printf("Result set successfully closed in %,d milliseconds.%n",
							end-start);
				}
				
				if (stmt != null) {
					
					start = System.currentTimeMillis();
					
					stmt.close();
					
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
				rs = null;
				stmt = null;
				con = null;

				System.out.printf("Resources released to the garbage collector.%n");
			}
		}
		
		System.out.printf("Program end.%n");
		
	}
}
