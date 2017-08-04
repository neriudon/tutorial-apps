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
package com.example.security.app.account;

import java.security.Principal;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.security.domain.model.Account;
import com.example.security.domain.service.userdetails.SampleUserDetails;

@Controller
@RequestMapping("account")
public class AccountController {

    @RequestMapping(method = RequestMethod.GET)
    public String view(/* (1) */ Principal principal, Model model) {
        // get login user information
        Authentication authentication = (Authentication) principal; // (2)
        // get UserDetails
        SampleUserDetails userDetails = (SampleUserDetails) authentication
                .getPrincipal(); // (3)
        // get account object
        Account account = userDetails.getAccount(); // (4)
        model.addAttribute(account);
        return "account/view";
    }
}
