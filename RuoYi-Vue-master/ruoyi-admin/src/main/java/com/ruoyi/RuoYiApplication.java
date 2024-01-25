package com.ruoyi;

import com.ruoyi.common.constant.SystemConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.spring.SpringUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

import java.util.Arrays;

/**
 * 启动程序
 * 
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class RuoYiApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(RuoYiApplication.class, args);
        initRedis();
        System.out.println("(♥◠‿◠)ﾉﾞ  若依启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");
    }

    static void initRedis() {
        String area="1\t116.405285\t39.904989\n" +
                    "2\t117.190182\t39.125596\n" +
                    "3\t114.502461\t38.045474\n" +
                    "4\t112.549248\t37.857014\n" +
                    "5\t123.429096\t41.796767\n" +
                    "6\t125.3245\t  43.886841\n" +
                    "7\t126.642464\t45.756967\n" +
                    "8\t121.472644\t31.231706\n" +
                    "9\t118.767413\t32.041544\n" +
                    "10\t120.153576\t30.287459\n" +
                    "11\t117.283042\t31.86119\n" +
                    "12\t119.306239\t26.075302\n" +
                    "13\t115.892151\t28.676493\n" +
                    "14\t117.000923\t36.675807\n" +
                    "15\t113.665412\t34.757975\n" +
                    "16\t114.298572\t30.584355\n" +
                    "17\t112.982279\t28.19409\n" +
                    "18\t113.280637\t23.125178\n" +
                    "19\t106.504962\t29.533155\n" +
                    "20\t104.065735\t30.659462\n" +
                    "21\t108.948024\t34.263161\n" +
                    "22\t111.670801\t40.818311\n" +
                    "23\t108.320004\t22.82402\n" +
                    "24\t110.33119\t20.031971\n" +
                    "25\t106.713478\t26.578343\n" +
                    "26\t102.712251\t25.040609\n" +
                    "27\t91.132212\t29.660361\n" +
                    "28\t103.823557\t36.058039\n" +
                    "29\t101.778916\t36.623178\n" +
                    "30\t106.278179\t38.46637\n" +
                    "31\t87.617733\t43.792818";
        try {
            RedisCache redisCache = SpringUtils.getBean(RedisCache.class);

            Arrays.stream(area.trim().split("\n"))
                    .forEach(s -> {
                        String[] strings = s.strip().split("(\\s+)");

                        redisCache.add(SystemConstants.REDIS_AREA_KEY,
                                        Float.parseFloat(strings[1]),
                                        Float.parseFloat(strings[2]),
                                        strings[0]);
                    });
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
