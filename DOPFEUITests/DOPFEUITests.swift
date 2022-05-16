//
//  DOPFEUITests.swift
//  DOPFEUITests
//
//  Created by Daniil Batin on 01.04.2022.
//

import XCTest

class DOPFEUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
    }

    func testCorrectlyAddingTextToCellInPeopleViewController() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Кирилл")
        app.buttons["+"].tap()
    
        XCTAssert(app.cells.staticTexts["Кирилл"].exists)
        
        
    }
    
    func testReloadButton() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Женя")
        app.buttons["+"].tap()
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        
        XCTAssertFalse(app.cells.staticTexts["Женя"].exists)
        
     
    }
    
    func testCorrectlyAddingProductTextToCellInProductViewController() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Продукти"].tap()
        app.textFields["Назва продукту"].tap()
        app.textFields["Назва продукту"].typeText("Молоко")
        app.textFields["Ціна"].tap()
        app.textFields["Ціна"].typeText("55")
        app.buttons["+"].tap()
        
        XCTAssert(app.cells.staticTexts["Молоко"].exists)
        
    }
    
    func testPickerViewInWhoPaysViewController() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Кирилл")
        app.buttons["+"].tap()
        
        app.buttons["Продукти"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Назва продукту"].tap()
        app.textFields["Назва продукту"].typeText("Молоко")
        app.textFields["Ціна"].tap()
        app.textFields["Ціна"].typeText("55")
        app.buttons["+"].tap()
        
        app.buttons["Хто платить?"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["Так"]/*[[".segmentedControls.buttons[\"Так\"]",".buttons[\"Так\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels["Молоко 55 грн"].swipeUp()
        app.pickerWheels["Кирилл"].swipeDown()
        app.buttons["Зберегти"].tap()
        
        XCTAssert(app.cells.staticTexts["Кирилл - Молоко 55.0 грн"].exists)
       
    }
    
    
    func testCorrectlyAddingResultsToCellInResultViewController() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Кирилл")
        app.buttons["+"].tap()
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Андрей")
        app.buttons["+"].tap()
        
        app.buttons["Продукти"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Назва продукту"].tap()
        app.textFields["Назва продукту"].typeText("Сыр")
        app.textFields["Ціна"].tap()
        app.textFields["Ціна"].typeText("120")
        app.buttons["+"].tap()
        
        app.buttons["Підрахувати "].tap()
    
        XCTAssert(app.cells.staticTexts["Вам потрібно заплатити: 60.0 грн"].exists)
    }
    
    
    func testCorrectlyAddingDepositInGaveMoneyViewController() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Старт"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Назад"].tap()
        app.buttons["Перезавантажити"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Кирилл")
        app.buttons["+"].tap()
        app.textFields["Ім'я людини"].tap()
        app.textFields["Ім'я людини"].typeText("Андрей")
        app.buttons["+"].tap()
        
        app.buttons["Продукти"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.textFields["Назва продукту"].tap()
        app.textFields["Назва продукту"].typeText("Сыр")
        app.textFields["Ціна"].tap()
        app.textFields["Ціна"].typeText("120")
        app.buttons["+"].tap()
        
        app.buttons["Хто платить?"].tap()
        app.wait(for: .notRunning, timeout: 0.5)
        app.buttons["Натисніть якщо хтось скинув грощі"].tap()
        app.tables.cells.containing(.staticText, identifier:"Кирилл").textFields["Скільки грошей?"].tap()
        app.tables.cells.containing(.staticText, identifier:"Кирилл").textFields["Скільки грошей?"].typeText("59")
        app.tap()
        app.buttons["Зберегти"].tap()
        app.buttons["Назад"].tap()
        
        app.buttons["Підрахувати "].tap()
    
        XCTAssert(app.cells.staticTexts["Вам потрібно заплатити: 1.0 грн"].exists)
    }

    

}
