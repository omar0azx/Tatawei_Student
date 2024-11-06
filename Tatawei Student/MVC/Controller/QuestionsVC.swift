//
//  QuestionsVC.swift
//  Tatawei Student
//
//  Created by testuser on 03/05/1446 AH.
//

import UIKit

class QuestionsVC: UIViewController, Storyboarded, UITableViewDataSource, UITableViewDelegate{

    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var myResult:[quations]! = [quations]()
    
    //MARK: - IBOutleats
    
    
    @IBOutlet weak var tableViewQuestions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AssignData()
        
        tableViewQuestions.dataSource = self
        tableViewQuestions.delegate = self
        

    }
    
    //MARK: - IBAcitions
    
    @IBAction func exit(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - Functions
  

    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.myResult?[section].expand ?? false {
            return 2
        }
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView ) -> Int {
        
        return self.myResult?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            
            cell.titleCell.text = self.myResult?[indexPath.section].question
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! QuestionCell
            
            cell.contentCell.text = self.myResult?[indexPath.section].answer
            
            cell.selectionStyle = .none
            
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let isExpand = (self.myResult?[indexPath.section].expand ?? false)
            self.myResult?[indexPath.section].expand = !isExpand
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: UITableView.RowAnimation.none)
        } else {

        }
    }

    func AssignData() {
        var A1 = quations()
        
        // السؤال الأول
        A1.question = "ما هو التطوع؟"
        A1.answer = "التطوع هو تقديم الفرد جزءًا من وقته وجهده للمشاركة في خدمة المجتمع بدون مقابل. يهدف التطوع إلى تحقيق منافع للمجتمع وللفرد، ويساهم في تعزيز المهارات وتنمية الإحساس بالمسؤولية."
        self.myResult.append(A1)

        // السؤال الثاني
        A1.question = "ما هي فوائد التطوع للطلاب؟"
        A1.answer = "التطوع يساعد الطلاب على تطوير مهارات جديدة، مثل القيادة، والتواصل، وإدارة الوقت. كما يساهم في تعزيز ثقتهم بأنفسهم ويتيح لهم فرصًا للتواصل مع أشخاص من خلفيات مختلفة، مما يزيد من فرص التعلم والتطوير الشخصي."
        self.myResult.append(A1)

        // السؤال الثالث
        A1.question = "كيف يمكنني العثور على فرص تطوعية مناسبة؟"
        A1.answer = "يمكنك العثور على فرص تطوعية من خلال البحث في المواقع المحلية للجمعيات والمنظمات الخيرية، والتواصل مع المدارس أو الجامعات التي قد توفر فرص تطوعية للطلاب. هناك أيضًا تطبيقات ومنصات مخصصة للتطوع يمكنك استخدامها."
        self.myResult.append(A1)

        // السؤال الرابع
        A1.question = "هل أحتاج إلى مهارات خاصة للتطوع؟"
        A1.answer = "معظم الفرص التطوعية لا تتطلب مهارات خاصة، لكن بعض الأنشطة قد تحتاج إلى مهارات محددة، مثل العمل مع الأطفال أو تقديم الإسعافات الأولية. على أي حال، يتم توفير التدريب الأساسي للمتطوعين في أغلب الأحيان."
        self.myResult.append(A1)

        // السؤال الخامس
        A1.question = "ما هي المدة الزمنية المطلوبة للتطوع؟"
        A1.answer = "تختلف المدة الزمنية حسب نوع التطوع ومتطلباته. هناك فرص تطوعية تستمر لبضع ساعات فقط، وأخرى تتطلب التزامًا أسبوعيًا أو شهريًا. يمكنك اختيار الفرص التي تتناسب مع جدولك الدراسي."
        self.myResult.append(A1)

        // السؤال السادس
        A1.question = "هل يمكن للتطوع أن يؤثر على دراستي بشكل إيجابي؟"
        A1.answer = "نعم، التطوع يمكن أن يؤثر بشكل إيجابي على الدراسة. من خلال المشاركة في الأنشطة التطوعية، يمكن للطلاب تطوير مهارات إدارة الوقت، والتحفيز الذاتي، مما يساعدهم على التوازن بين الدراسة والأنشطة الإضافية."
        self.myResult.append(A1)

        // السؤال السابع
        A1.question = "هل يمكن أن يساعدني التطوع في بناء سيرتي الذاتية؟"
        A1.answer = "بالتأكيد، يضيف التطوع قيمة كبيرة إلى السيرة الذاتية، حيث يظهر لأصحاب العمل أنك شخص ملتزم ولديك رغبة في مساعدة الآخرين. كما يعكس قدرتك على العمل الجماعي وحل المشكلات، وهي مهارات مهمة في سوق العمل."
        self.myResult.append(A1)

        // السؤال الثامن
        A1.question = "ما هي حقوقي كمتطوع؟"
        A1.answer = "كمتطوع، لديك الحق في الحصول على تدريب كافٍ للقيام بمهامك، والحق في العمل في بيئة آمنة ومحترمة. كما يحق لك الحصول على معلومات واضحة حول متطلبات الدور التطوعي ومدة الالتزام المطلوبة."
        self.myResult.append(A1)

        // السؤال التاسع
        A1.question = "كيف أستطيع التطوع إذا كنت مشغولاً بالدراسة؟"
        A1.answer = "يمكنك البحث عن فرص تطوعية مرنة تتناسب مع جدولك الدراسي، مثل التطوع في عطلات نهاية الأسبوع أو خلال الإجازات. العديد من الفرص التطوعية تسمح بالعمل عن بُعد أو بجدول زمني مرن."
        self.myResult.append(A1)
    }

    
    
}

