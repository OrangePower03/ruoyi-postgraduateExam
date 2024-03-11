package com.ruoyi.run;

import com.ruoyi.user.domain.Field;
import com.ruoyi.user.mapper.FieldMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

@Component
public class SQLRunner implements ApplicationRunner {
    @Resource
    private FieldMapper fieldMapper;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        if(fieldMapper.getCount() >= 10) {
            return ;
        }
        ClassPathResource resource = new ClassPathResource("data/field.txt");
        InputStream inputStream=resource.getInputStream();
        String message = new String(inputStream.readAllBytes());
        String[] splitByDegree = message.split("@\r\n");
        String professional=splitByDegree[0];
        String academic=splitByDegree[1];

        String[] majors = professional.split("\n");
        for (String major : majors) {
            String[] split = major.split(":");
            String parentCode = split[0].split(",")[0];
            String[] specificMajors = split[1].split(";");
            for (String specificMajor : specificMajors) {
                String[] codeAndName = specificMajor.split(",");
                String code=codeAndName[0];
                String name=codeAndName[1];
                Field field=new Field();
                field.setFieldCode(code);
                field.setParentId(Long.valueOf(parentCode));
                field.setMajorType(1L);
                field.setFieldName(name);
                fieldMapper.insertField(field);
            }
        }


        majors = academic.split("\n");
        for (String major : majors) {
            String[] split = major.split(":");
            String parentCode = split[0].split(",")[0];
            String[] specificMajors = split[1].split(";");
            for (String specificMajor : specificMajors) {
                String[] codeAndName = specificMajor.split(",");
                String code=codeAndName[0];
                String name=codeAndName[1];
                Field field=new Field();
                field.setFieldCode(code);
                field.setParentId(Long.valueOf(parentCode));
                field.setMajorType(2L);
                field.setFieldName(name);
                fieldMapper.insertField(field);
            }
        }
    }
}
