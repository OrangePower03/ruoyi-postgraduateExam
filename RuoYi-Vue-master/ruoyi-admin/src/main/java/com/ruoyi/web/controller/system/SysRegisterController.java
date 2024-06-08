package com.ruoyi.web.controller.system;

import com.ruoyi.user.domain.UserScoreInfo;
import com.ruoyi.user.service.IUserScoreInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.SysRegisterService;
import com.ruoyi.system.service.ISysConfigService;

/**
 * 注册验证
 * 
 */
@RestController
public class SysRegisterController extends BaseController
{
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private IUserScoreInfoService userScoreInfoService;


    @Autowired
    private ISysConfigService configService;

    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user)
    {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser"))))
        {
            return error("当前系统没有开启注册功能！");
        }
        String msg = registerService.register(user);
        if(StringUtils.isEmpty(msg)) {
            UserScoreInfo userScoreInfo = new UserScoreInfo();
            userScoreInfo.setScoreAll(370L);
            userScoreInfo.setScoreMajor(100L);
            userScoreInfo.setScoreMath(100L);
            userScoreInfo.setScorePolitics(85L);
            userScoreInfo.setScoreEnglish(85L);
            userScoreInfo.setMajorName("金融");
            userScoreInfo.setMajorType(1L);
            userScoreInfo.setAreaName("上海");
            userScoreInfo.setUserId(user.getUserId());
            userScoreInfoService.insertWxUserScoreInfo(userScoreInfo);
            return success();
        }
        return error(msg);
    }
}
