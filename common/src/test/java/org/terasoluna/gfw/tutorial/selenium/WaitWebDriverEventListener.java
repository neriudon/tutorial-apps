/*
 * Copyright (C) 2013-2018 NTT DATA Corporation
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
package org.terasoluna.gfw.tutorial.selenium;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openqa.selenium.TimeoutException;

import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.JavascriptExecutor;

public class WaitWebDriverEventListener extends
                                                WebDriverEventListenerAdapter {

    protected final Log logger = LogFactory.getLog(getClass());

    protected static Wait<WebDriver> wait;

    protected long webDriverWait = 5;

    protected long webDriverSleepWait = 100;

    @Override
    public void afterClickOn(WebElement element, WebDriver driver) {
        try {
            wait = new WebDriverWait(driver, webDriverWait, webDriverSleepWait);
            wait.until(
                    (ExpectedCondition<Boolean>) wd -> ((JavascriptExecutor) wd)
                            .executeScript("return document.readyState").equals(
                                    "loading"));
            wait.until(
                    (ExpectedCondition<Boolean>) wd -> ((JavascriptExecutor) wd)
                            .executeScript("return document.readyState").equals(
                                    "complete"));
        } catch (TimeoutException e) {
            logger.debug("loading is not done");
        }
    }

}
