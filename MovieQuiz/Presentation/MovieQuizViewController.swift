import UIKit

final class MovieQuizViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var buttonsStack: UIStackView!
    @IBOutlet private weak var counterLabel: UILabel!
    
    // MARK: - Properties
    
    private let questionManager = MokQuestionManager()
    private var questionCount: Int = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mainBackground")
        configureSubviews()
        setQuestion(question: questionManager.questions[questionCount])
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
        
        mainImage.layer.cornerRadius = 20
        
        buttonsStack.arrangedSubviews.forEach({ view in
            view.layer.cornerRadius = 15
            if let button = view as? UIButton {
                button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            }
        })
    }
    
    private func setQuestion(question: Question) {
        mainImage.image = UIImage(named: question.image)
        questionLabel.text = question.question
        counterLabel.text = "\(questionCount + 1)/\(questionManager.questions.count)"
        mainImage.layer.borderWidth = 0
    }
    
    private func checkAnswer(_ answer: Bool) {
        let colorName: String = questionManager.questions[questionCount].answer == answer
        ? "greenBorder"
        : "redBorder"
        
        mainImage.layer.borderWidth = 8
        mainImage.layer.borderColor = UIColor(named: colorName)?.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            
            questionCount += 1
            if questionCount < questionManager.questions.count {
                setQuestion(question: questionManager.questions[questionCount])
            } else {
                createAlert()
            }
        }
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: "Раунд окончен", message: nil, preferredStyle: .alert)
        let playAgainAction = UIAlertAction(
            title: "Сыграть еще раз",
            style: .default,
            handler: { action in
                self.questionCount = 0
                self.setQuestion(
                    question: self.questionManager.questions[self.questionCount]
                )
            }
        )
        
        alert.addAction(playAgainAction)
        present(alert, animated: true, completion: nil)
    }
}

struct Question {
    let image: String
    let rating: Double
    let question: String
    let answer: Bool
}

struct MokQuestionManager {
    let questions: [Question] = [
        .init(image: "The Godfather", rating: 9.2, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "The Dark Knight", rating: 9, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "Kill Bill", rating: 8.1, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "The Avengers", rating: 8, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "Deadpool", rating: 8, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "The Green Knight", rating: 6.6, question: "Рейтинг этого фильма больше чем 6?", answer: true),
        .init(image: "Old", rating: 5.8, question: "Рейтинг этого фильма больше чем 6?", answer: false),
        .init(image: "The Ice Age Adventures of Buck Wild", rating: 4.3, question: "Рейтинг этого фильма больше чем 6?", answer: false),
        .init(image: "Tesla", rating: 5.1, question: "Рейтинг этого фильма больше чем 6?", answer: false),
        .init(image: "Vivarium", rating: 5.8, question: "Рейтинг этого фильма больше чем 6?", answer: false)
    ]
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
