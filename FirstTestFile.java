package cctestngpackage;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;
import org.openqa.selenium.WebElement;

import org.testng.annotations.Test;

public class FirstTestFile 
{
	public String baseUrl = "http://localhost:8080/CodeChallenge/index.html";
    String driverPath = "C:\\myDrivers\\latest\\chromedriver.exe";
    public WebDriver driver ; 

    @BeforeTest
    public void setWebDriverProperty()
    {
        System.setProperty("webdriver.chrome.driver", driverPath);
    }
    
    @Test
    public void VerifyHomePageTitle() 
    {
    	driver = new ChromeDriver();
        
        driver.get(baseUrl);
        String expectedTitle = "Weather";
        String actualTitle = driver.getTitle();
        Assert.assertEquals(actualTitle, expectedTitle);
        driver.close();
    }
    @Test
    public void VerifyStoreLink() 
    {
    	driver = new ChromeDriver();
        
        driver.get(baseUrl);
        WebElement storeEle = driver.findElement(By.partialLinkText("Store Weather"));
        storeEle.click();		
        Assert.assertEquals(driver.getCurrentUrl(),"http://localhost:8080/CodeChallenge/Store.html");
        driver.close();
    }
    @Test
    public void VerifyRetrieveLink() 
    {
    	driver = new ChromeDriver();
        
        driver.get(baseUrl);
        WebElement retrieveEle = driver.findElement(By.linkText("Retrieve Weather"));
        retrieveEle.click();		
        Assert.assertEquals(driver.getCurrentUrl(),"http://localhost:8080/CodeChallenge/Retrieve.html");
        driver.close();
    }
    @Test
    public void StoreWeatherTestCase1() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Store.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("charlotte");
        subButton.click();
        Assert.assertTrue(driver.getPageSource().contains("Data inserted successfully"));
        driver.close();
    }
    @Test
    public void StoreWeatherTestCase2() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Store.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("12345");
        subButton.click();
        Assert.assertEquals(driver.getCurrentUrl(),"http://localhost:8080/CodeChallenge/Store.html");
        driver.close();
    }
    @Test
    public void StoreWeatherTestCase3() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Store.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("abcde");
        subButton.click();
        Assert.assertTrue(driver.getPageSource().contains("Invalid city entered"));
        driver.close();
    }
    @Test
    public void StoreWeatherTestCase4() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Store.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("!@#$");
        subButton.click();
        Assert.assertEquals(driver.getCurrentUrl(),"http://localhost:8080/CodeChallenge/Store.html");
        driver.close();
    }
    @Test
    public void StoreWeatherTestCase5() 
    {
    	driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/weather.jsp?city=charlotte");
       
        Assert.assertTrue(driver.getPageSource().contains("Data inserted successfully"));
        driver.close();
     }
    @Test
    public void StoreWeatherTestCase6() 
    {
    	driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/weather.jsp?city=abcd");
       
        Assert.assertTrue(driver.getPageSource().contains("Invalid city entered"));
        driver.close();
     }
    @Test
    public void RetrieveWeatherTestCase1() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Retrieve.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("delhi");
        subButton.click();
        
        boolean result = driver.getPageSource().contains("No records found in database!") || driver.getPageSource().contains("Wind Speed");
        
        Assert.assertTrue(result);
        driver.close();
    }    
    @Test
    public void RetrieveWeatherTestCase2() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Retrieve.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("123456");
        subButton.click();
        
        Assert.assertEquals(driver.getCurrentUrl(),"http://localhost:8080/CodeChallenge/Retrieve.html");
        driver.close();
    }
    @Test
    public void RetrieveWeatherTestCase3() 
    {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/CodeChallenge/Retrieve.html");
        
        WebElement cityText = driver.findElement(By.name("city"));
        WebElement subButton = driver.findElement(By.xpath("/html/body/form/input[2]"));
        
        cityText.sendKeys("abcde");
        subButton.click();
        
        Assert.assertTrue(driver.getPageSource().contains("No records found in database!"));
        driver.close();
    }
    
}
