package com.ruoyi.framework.security.filter;

import java.io.IOException;
import java.util.concurrent.TimeUnit;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.http.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.TokenService;

/**
 * token过滤器 验证token有效性
 * 并添加反爬机制
 */
@Component
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter
{
    private static final String DEFEND_CRAWLER_TAG="DEFEND_CRAWLER:";
    // 60s访问100次
    private static final int CRAWLER_EXPIRE_SECONDS=60;
    private static final int CRAWLER_MAX_COUNT=100;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private RedisCache redisCache;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException
    {
        LoginUser loginUser = tokenService.getLoginUser(request);
        
        if (StringUtils.isNotNull(loginUser) && StringUtils.isNull(SecurityUtils.getAuthentication()))
        {
            tokenService.verifyToken(loginUser);
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(loginUser, null, loginUser.getAuthorities());
            authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            
            doDefendCrawler(loginUser, response);
        }
        chain.doFilter(request, response);
    }

    private void doDefendCrawler(LoginUser loginUser, HttpServletResponse response) {
        Long userId = loginUser.getUserId();
        String key = DEFEND_CRAWLER_TAG + userId;
        Long count = redisCache.incr(key);
        // 在规定时间内未访问过本系统，设置一下过期时间
        if(count == 1) {
            redisCache.expire(key, CRAWLER_EXPIRE_SECONDS, TimeUnit.SECONDS);
        }
        else {
            redisCache.setExpireIfPermanent(key, CRAWLER_EXPIRE_SECONDS, TimeUnit.SECONDS);
            if(count > CRAWLER_MAX_COUNT) {
//                WebUtils.renderString(response, "系统访问次数受限，请稍后再来", 401);
                throw new ServiceException("系统访问次数受限，请稍后再来", 401);
            }
        }
    }
}
