import UIKit

final class MovieQuizViewController: UIViewController, ResultAlertPresenterDelegate {
    
    // MARK: - Constants
    
    private let boldFont: UIFont = UIFont(name: "YSDisplay-Bold", size: 23) ?? UIFont()
    private let mediumFont: UIFont = UIFont(name: "YSDisplay-Medium", size: 20) ?? UIFont()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var buttonsStack: UIStackView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var questionCounterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    // MARK: - Properties
    
    private let questionManager = MokQuestionManager()
    private var statisticService: StatisticService!
    private var questionCount: Int = {
        return UserDefaults.standard.integer(forKey: "QuestionCountKey")
    }() {
        didSet {
            UserDefaults.standard.setValue(questionCount, forKey: "QuestionCountKey")
        }
    }
    private var resultQuestionCount: Int = {
        return UserDefaults.standard.integer(forKey: "ResultQuestionCountKey")
    }() {
        didSet {
            UserDefaults.standard.setValue(resultQuestionCount, forKey: "ResultQuestionCountKey")
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mainBackground")
        configureSubviews()
        setQuestion(question: questionManager.questions[questionCount])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBActions
    
    @IBAction private func noAnswer(_ sender: UIButton) {
        checkAnswer(false)
    }
    
    @IBAction private func yesAnswer(_ sender: UIButton) {
        checkAnswer(true)
    }
    
    // MARK: - Private methods
    
    private func configureSubviews() {
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.font = boldFont
        
        questionCounterLabel.font = mediumFont
        counterLabel.font = mediumFont
        
        noButton.titleLabel?.font = mediumFont
        yesButton.titleLabel?.font = mediumFont
        
        mainImage.layer.cornerRadius = 20
        
        buttonsStack.arrangedSubviews.forEach({ view in
            view.layer.cornerRadius = 15
        })
    }
    
    private func setQuestion(question: Question) {
        mainImage.image = UIImage(named: question.image)
        questionLabel.text = question.question
        questionLabel.sizeToFit()
        counterLabel.text = "\(questionCount + 1)/\(questionManager.questions.count)"
        mainImage.layer.borderWidth = 0
    }
    
    private func checkAnswer(_ answer: Bool) {
        let colorName: String = questionManager.questions[questionCount].answer == answer
        ? "greenBorder"
        : "redBorder"
        
        if questionManager.questions[questionCount].answer == answer {
            resultQuestionCount += 1
        }
        
        mainImage.layer.borderWidth = 8
        mainImage.layer.borderColor = UIColor(named: colorName)?.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            print(resultQuestionCount)
            questionCount += 1
            if questionCount < questionManager.questions.count {
                setQuestion(question: questionManager.questions[questionCount])
            } else {
                createAlert()
            }
        }
    }
    
    private func createAlert() {
        let title = "Раунд окончен"
        let message = "Ваш результат: \(resultQuestionCount)/\(questionManager.questions.count)"
        
        let alert = ResultAlertPresenter(title: title, message: message, delegate: self)
        alert.showAlert(vc: self)
    }
    
    func restartAction() {
        self.questionCount = 0
        self.resultQuestionCount = 0
        self.setQuestion(
            question: self.questionManager.questions[self.questionCount]
        )
    }
}




/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
