package com.ruoyi.common.utils;

import com.ruoyi.common.exception.ServiceException;
import reactor.util.annotation.NonNull;

import java.util.Collection;
import java.util.Objects;

public class AssertUtils {
    public static void nonNull(Object obj, String msg) {
        isTrue(obj != null, msg);
    }

    public static void nonEmpty(Collection<?> obj, String msg) {
        isTrue(StringUtils.isNotEmpty(obj), msg);
    }

    public static void isTrue(@NonNull Boolean ret, String msg) {
        if(!ret)
            throw new ServiceException(msg);
    }

    public static <T> void isEquals(T o1, T o2, String msg) {
        isTrue(Objects.equals(o1, o2), msg);
    }
}
