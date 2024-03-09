package com.ruoyi.user.domain.common;

import lombok.Data;

@Data
public class ScoreCommon {
    public Long scoreAll=0L;
    public Long scoreMath=0L;
    public Long scoreEnglish=0L;
    public Long scorePolitics=0L;
    public Long scoreMajor=0L;

    /**
     * 计算平均值的方法，你先加好再调用这个
     */
    public void average(int size) {
        scoreAll /= size;
        scoreMath /= size;
        scoreEnglish /= size;
        scorePolitics /= size;
        scoreMajor /= size;
    }
}
