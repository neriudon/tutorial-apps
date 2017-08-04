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
package com.example.security.domain.service.userdetails;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.example.security.domain.model.Account;

public class SampleUserDetails extends User {
    private static final long serialVersionUID = 1L;

    private final Account account; // (1)

    public SampleUserDetails(Account account) {
        super(account.getUsername(), account.getPassword(), createRole(account)); // (2)
        this.account = account;

    }

    private static Collection<? extends GrantedAuthority> createRole(
            Account account) {
        // sample role
        return Collections
                .singletonList(new SimpleGrantedAuthority("ROLE_USER")); // (3)
    }

    public Account getAccount() { // (4)
        return account;
    }
}
