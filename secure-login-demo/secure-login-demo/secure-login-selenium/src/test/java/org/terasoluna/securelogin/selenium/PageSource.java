package org.terasoluna.securelogin.selenium;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.WebDriver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;

public class PageSource {
    private static final Logger logger = LoggerFactory
            .getLogger(PageSource.class);

    @Value("${selenium.enablePageSource}")
    protected boolean enablePageSource;

    private File evidenceSavingDirectory;

    private final AtomicInteger sequence = new AtomicInteger(0);

    public void setUp(File evidenceSavingDirectory) {
        sequence.set(0);
        this.evidenceSavingDirectory = evidenceSavingDirectory;
    }

    public void save(WebDriver webDriver) {
        save(webDriver, (String) null);
    }

    public void save(WebDriver webDriver, String subTitle) {
        if (!enablePageSource) {
            return;
        }
        saveForced(webDriver, subTitle);
    }

    public void saveForced(WebDriver webDriver, String subTitle) {

        if (StringUtils.isEmpty(subTitle)) {
            subTitle = "";
        } else {
            subTitle = "-" + subTitle;
        }

        int sequenceNo = sequence.incrementAndGet();
        String evidenceFile = String.format("page_source_%03d%s.txt",
                sequenceNo, subTitle);
        File pageSourceFile = new File(evidenceSavingDirectory, evidenceFile);

        try {
            FileUtils.writeStringToFile(pageSourceFile, webDriver
                    .getPageSource());

        } catch (IOException e) {
            logger.error(e.toString());
        }

    }
}
