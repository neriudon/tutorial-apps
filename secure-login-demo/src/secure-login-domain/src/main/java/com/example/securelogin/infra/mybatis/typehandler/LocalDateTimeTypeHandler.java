/*
 * Copyright (C) 2013-2017 NTT DATA Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
package com.example.securelogin.infra.mybatis.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class LocalDateTimeTypeHandler extends BaseTypeHandler<LocalDateTime> {

    @Override
    public LocalDateTime getNullableResult(ResultSet rs, String columnName)
            throws SQLException {
        return toDateTime(rs.getTimestamp(columnName));
    }

    @Override
    public LocalDateTime getNullableResult(ResultSet rs, int columnIndex)
            throws SQLException {
        return toDateTime(rs.getTimestamp(columnIndex));
    }

    @Override
    public LocalDateTime getNullableResult(CallableStatement cs, int columnIndex)
            throws SQLException {
        return toDateTime(cs.getTimestamp(columnIndex));
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i,
            LocalDateTime parameter, JdbcType jdbcType) throws SQLException {
        ps.setTimestamp(i, Timestamp.valueOf(parameter));
    }

    private LocalDateTime toDateTime(Timestamp timestamp) {
        if (timestamp == null) {
            return null;
        } else {
            return timestamp.toLocalDateTime();
        }
    }

}
