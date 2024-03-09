package com.ruoyi.user.domain.common;

import com.ruoyi.user.domain.Score;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Deprecated
public class ScoreWithSchoolName extends Score {
    String schoolName;

    @Override
    public boolean equals(Object other) {
        return schoolName.equals(((ScoreWithSchoolName) other).getSchoolName());
    }

    @Override
    public int hashCode() {
        return schoolName.hashCode();
    }

}
