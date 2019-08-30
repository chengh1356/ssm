import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

public class DirverTest {
    public static void main(String[] args) throws SQLException {
        DriverManagerDataSource source = new DriverManagerDataSource();
        source.setDriverClassName("com.mysql.jdbc.Driver");
        source.setUrl("jdbc:mysql://localhost:3306/ssm");
        source.setUsername("chen");
        source.setPassword("chen1234");
        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(source);

        String sql = "select * from t_user";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
        Connection conn = source.getConnection();
        if(!conn.isClosed())
            System.out.println("Succeeded connecting to the Database!");  //连接成功提示
        Statement statement = conn.createStatement();
                                 //从表t_users里获取内容
        ResultSet rs = statement.executeQuery(sql);
        while(rs.next()) {
            System.out.println(rs.getString("user_id")+"");                  //输出t_user表里的id
        }
    }
}
