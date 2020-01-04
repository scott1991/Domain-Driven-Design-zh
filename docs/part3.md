# 第三部分 通过重构来加深理解

> III: Refactoring Toward Deeper Insight

Part II of this book laid a foundation for maintaining the correspondence between model and implementation. Using a proven set of basic building blocks along with consistent language brings some sanity to the development effort.

> 本书的第二部分为维护模型和实现之间的对应关系打下了基础。在开发过程中使用一系列成熟的基本构造块并运用一致的语言，能够使开发工作更加清晰而有条理。

Of course, the real challenge is to actually find an incisive model, one that captures subtle concerns of the domain experts and can drive a practical design. Ultimately, we hope to develop a model that captures a deep understanding of the domain. This should make the software more in tune with the way the domain experts think and more responsive to the user’s needs. This part of the book will clarify that goal, describe the process by which it can be approached, and explain some design principles and patterns to apply to make the design accommodate the needs of the application as well as the developers themselves.

> 当然，我们面临的真正挑战是找到深层次的模型，这个模型不但能够捕捉到领域专家的微妙的关注点，还可驱动切实可行的设计。我们的最终目的是开发出能够捕捉到领域深层含义的模型。以这种方式设计出来的软件不但更加贴近领域专家的思维方式，而且能更好地满足用户的需求。本部分将会对这个目标加以说明并详细描述其实现过程，同时也会解释某些设计原则和模式。我们应用这些原则和模式来得到满足应用程序以及开发人员自身需求的设计。

Success developing useful models comes down to three points.

> 要想成功地开发出实用的模型，需要注意以下 3 点。

1. Sophisticated domain models are achievable and worth the trouble.
2. They are seldom developed except through an iterative process of refactoring, including close involvement of the domain experts with developers interested in learning about the domain.
3. They may call for sophisticated design skills to implement and to use effectively.

---

> - 1. 复杂巧妙的领域模型是可以实现的，也是值得我们去花费力气实现的。
> - 2. 这样的模型离开不断的重构是很难开发出来的，重构需要领域专家和热爱学习领域知识的开发人员密切参与进来。
> - 3. 要实现并有效地运用模型，需要精通设计技巧。

## LEVELS OF REFACTORING 重构的层次

Refactoring is the redesign of software in ways that do not change its functionality. Rather than making elaborate up-front design decisions, developers take code through a continuous series of small, discrete design changes, each leaving existing functionality unchanged while making the design more flexible or easier to understand. A suite of automated unit tests allows relatively safe experimentation with the code. The process frees the developers from the need to look far ahead.

> 重构就是在不改变软件功能的前提下重新设计它。开发人员无需在着手开发之前做出详细的设计决策，只需要在开发过程中不断小幅调整设计即可，这不但能够保证软件原有的功能不变，还可使整个设计更加灵活易懂。自动化的单元测试套件能够保证对代码进行相对安全的试验。这个过程解放了开发人员，使他们不再需要提前考虑将来的事情。

But nearly all the literature on how to refactor focuses on mechanical changes to the code that make it easier to read or to enhance at a very detailed level. The approach of “refactoring to patterns”1 can give a higher-level target to the refactoring process when a developer recognizes an opportunity to apply an established design pattern. Still, it is a primarily technical view of the quality of a design.

> 然而，几乎所有关于重构的文献都专注于如何机械地修改代码，以使其更具可读性或在非常细节的层次上有所改进。如果开发人员能够看准时机，利用成熟的设计模式进行开发，那么“通过重构得到模式”（refactoring to patterns）这种方式就可以让重构过程更上一层楼。不过，这依然是从技术视角来评估设计的质量。

The refactorings that have the greatest impact on the viability of the system are those motivated by new insights into the domain or those that clarify the model’s expression through the code. This type of refactoring does not in any way replace the refactorings to design patterns or the micro-refactorings, which should proceed continuously. It superimposes another level: refactoring to a deeper model. Executing a refactoring based on domain insight often involves a series of micro-refactorings, but the motivation is not just the state of the code. Rather, the micro-refactorings provide convenient units of change toward a more insightful model. The goal is that not only can a developer understand what the code does; he or she can also understand why it does what it does and can relate that to the ongoing communication with the domain experts.

> 有些重构能够极大地提高系统的可用性，它们要么源于对领域的新认知，要么能够通过代码清晰地表达出模型的含义。这些重构不能取代设计模式重构和代码细节重构，这两种重构应该持续进行。但前者添加了另一种重构层次：为实现更深层模型而进行的重构。在深入理解领域的基础上进行重构，通常需要实现一系列的代码细节重构，但这么做绝不仅仅是为了改进代码状态。相反，代码细节重构是一组操作方便的修改单元，通过这些重构可以得到更深层次的模型。其目标在于：开发人员通过重构不仅能够了解代码实现的功能，还能明白个中原因，并把它们与领域专家的交流联系起来。

The catalog in Refactoring (Fowler 1999) covers most of the micro-refactorings that come up regularly. Each is motivated primarily by some problem that can be observed in the code itself. By contrast, domain models are transformed in such a range of ways as new insights emerge that a comprehensive catalog would be impossible to compile.

> 《重构》[Fowler 1999]一书中所列出的重构分类涵盖了大部分常用的代码细节重构。这些重构主要是为了解决一些可以从代码中观察到的问题。相比之下，领域模型会随着新认识的出现而不断变化，由于其变化如此多样，以至于根本无法整理出一个完整的目录。

Modeling is as inherently unstructured as any exploration. Refactoring to deeper insight should follow wherever learning and deep thinking lead. Published collections of successful models can be helpful, as discussed in Chapter 11, but we shouldn’t get sidetracked trying to reduce domain modeling to a cookbook or a toolkit. Modeling and design call for creativity. The next six chapters will suggest some specific approaches to thinking about improving a domain model, along with the design that brings it to life.

> 与所有的探索活动一样，建模本质上是非结构化的。要跟随学习与深入思考所指引的一切道路，然后据此重构，才能得到更深层的理解。尽管已发布的成功模型会对我们大有帮助（第 11 章将会提及），但是不能因此将领域建模简化为照本宣科的行为，当其是秘籍类的书籍或者工具包，依样画葫芦。建模和设计都需要你发挥创造力。接下来的 6 章将会给出一些改进领域模型的具体思考方式以及可实现这些领域模型的设计方法。

## DEEP MODELS 深层模型

The traditional way of explaining object analysis involves identifying nouns and verbs in the requirements documents and using them as the initial objects and methods. This explanation is recognized as an oversimplification that can be useful for teaching object modeling to beginners. The truth is, though, that initial models usually are naive and superficial, based on shallow knowledge.

> 对象分析的传统方法是先在需求文档中确定名词和动词，并将其作为系统的初始对象和方法。这种方式太过简单，只适用于教导初学者如何进行对象建模。事实上，初始模型通常都是基于对领域的浅显认知而构建的，既不够成熟也不够深入。

For example, I once worked on a shipping application for which my initial idea of an object model involved ships and containers. Ships moved from place to place. Containers were associated and disassociated through load and unload operations. That is an accurate description of some physical shipping activities. It does not turn out to be a very useful model for shipping business software.

> 例如，我曾参与过一个运输应用系统的开发，我的初始想法是构建一个包括货轮（ship）和集装箱的对象模型。货轮将货物从一个地点运送到另一个地点。集装箱则通过装卸操作与货轮建立关联或解除关联。这确实能够准确描述一部分实际运输活动。但事实证明，它对于运输业务的软件实现并没有太多帮助。

Eventually, after months working with shipping experts through many iterations, we evolved a quite different model. It was less obvious to a layperson, but much more relevant to the experts. It was refocused on the business of delivering cargo.

> 最终，在与运输专家一起工作了几个月并进行了多次迭代后，我们得到了一个完全不同的模型。在外行人看来，它也许没那么浅显易懂，但却能贴切地反映出专家的想法。这个模型的关注点再次回到了运送货物的业务。

The ships were still there, but abstracted in the form of a “vessel voyage,” a particular trip scheduled for a ship, train, or other carrier. The ship itself was secondary, and could be substituted at the last minute for maintenance or a slipping schedule, while the vessel voyage went on as planned. The shipping container all but disappeared from the model. It did emerge in a cargo-handling application in a different, very complex form, but in the context of the original application, the container was an operational detail. The physical movement of the cargo took a back seat to the transfers of legal responsibility for that cargo. Less obvious objects, such as the “bill of lading,” came to the fore.

> 我们依然保留了 ship，但是将其抽象为“船只航次”（vessel voyage），即货轮、火车或其他运输工具的某一调度好的航程。货轮本身不再重要，如遇维修或计划变动可临时改用其他方式，只要保证原定航次按计划执行即可。运输集装箱则完全从模型中移除了。它现在以一种完全不同的复杂形式出现在货物装卸应用程序中，而在原来的应用程序中，集装箱变成了操作细节。货物实际的位臵变化已不重要，重要的是其法律责任的转移。原来一些诸如“提货单”之类不被关注的对象也出现在模型中。

Whenever new object modelers showed up on the project, what was their first suggestion? The missing classes: ship and container. They were smart people. They just hadn’t gone through the processes of discovery.

> 每当有新的对象建模人员加入这个项目时，他们首先提出的建议是什么？就是添加“货轮”和“集装箱”这两个缺少的类。他们都很聪明，只不过还没有仔细揣摩运输领域的知识罢了。

A deep model provides a lucid expression of the primary concerns of the domain experts and their most relevant knowledge while it sloughs off the superficial aspects of the domain. This definition doesn’t mention abstraction. A deep model usually has abstract elements, but it may well have concrete elements where those cut to the heart of the problem.

> 深层模型能够穿过领域表象，清楚地表达出领域专家们的主要关注点以及最相关的知识。以上定义并没有涉及抽象。事实上，深层模型通常含有抽象元素，但在切中问题核心的关键位臵也同样会出现具体元素。

Versatility, simplicity, and explanatory power come from a model that is truly in tune with the domain. One feature such models almost always have is a simple, though possibly abstract, language that the business experts like to use.

> 恰当反映领域的模型通常都具有功能多样、简单易用和解释力强的特性。这种模型的共同之处在于：它们提供了一种业务专家青睐的简单语言，尽管这种语言可能也是抽象的。

## DEEP MODEL/SUPPLE DESIGN 深层模型/柔性设计

In a process of constant refactoring, the design itself needs to support change. Chapter 10 looks at ways to make a design easy to work with, both for those changing it and for those integrating it with other parts of the system.

> 在不断重构的过程中，设计本身也需要支持重构所带来的变化。第 10 章将会探讨如何使设计更易于使用，不但方便修改还能够简单地将其与系统其他部分集成。

Certain characteristics of a design make it easier to change and use. They are not complicated, but they are challenging. “Supple design” and ways to approach it are the subjects of Chapter 10.

> 设计自身的某些特性就可以使其更易于修改和使用。这些特性并不复杂，却很有挑战性。第 10 章将主要讨论“柔性设计”（supple design）及其实现方法。

One bit of luck is that the very act of transforming the model and code again and again—if each change reflects new understanding—can bring about flexibility at just the points where change is most needed, along with easy ways of doing the common things. A well-worn glove becomes supple at the points where the fingers bend, while other parts are stiff and protective. So although there is a lot of trial and error involved in this approach to modeling and design, the changes can actually become easier to make, and the repeated changes actually move us toward a supple design.

> 幸运的是，如果每次对模型和代码所进行的修改都能反映出对领域的新理解，那么通过不断的重构就能给系统最需要修改的地方增添灵活性，并找到简单快捷的方式来实现普通的功能。戴久了的手套在手指关节处会变得柔软；而其他部分则依然硬实，可起到保护的作用。同样道理，用这种方式来进行建模和设计时，虽然需要反复尝试、不断改正错误，但是对模型和设计的修改却因此而更容易实现，同时反复的修改也能让我们越来越接近柔性设计。

In addition to facilitating change, a supple design contributes to the refinement of the model itself. A MODEL-DRIVEN DESIGN stands on two legs. A deep model makes possible an expressive design. At the same time, a design can actually feed insight into the model discovery process when it has the flexibility to let a developer experiment and the clarity to show a developer what is happening. This half of the feedback loop is essential, because the model we are looking for is not just a nice set of ideas: it is the foundation of the system.

> 柔性设计除了便于修改，还有助于改进模型本身。MODEL-DRIVEN DESIGN 需要以下两个方面的支持：深层模型使设计更具表现力；同时，当设计的灵活性可以让开发人员进行试验，而设计又能清晰地表达出领域含义时，那么这个设计实际上就能够将开发人员的深层理解反馈到整个模型发现的过程中。这段反馈回路是很重要的，因为我们所寻求的模型并不仅仅只是一套好想法：它还应该是构建系统的基础。

## THE DISCOVERY PROCESS 发现过程

To create a design really fitted to the problem at hand, you must first have a model that captures the central relevant concepts of the domain. Actively searching for these concepts and bringing them into the design is the subject of Chapter 9, “Making Implicit Concepts Explicit.”

> 要想创建出确实能够解决当前问题的设计，首先必须拥有可捕捉到领域核心概念的模型。第 9 章将会介绍如何主动搜寻这些概念，并将它们融入到设计中。

Because of the close relationship between model and design, the modeling process comes to a halt when the code is hard to refactor. Chapter 10, “Supple Design,” discusses how to write software for software developers, not least yourself, so that it is productive to extend and change. This effort goes hand in hand with further refinements to the model. It often entails more advanced design techniques and more rigor in model definitions.

> 由于模型和设计之间具有紧密的关系，因此如果代码难于重构，建模过程也会停滞不前。第 10 章将会探讨如何为软件开发者（尤其是为你自己）编写软件，以使开发人员能够高效地扩展和修改代码。这一设计过程与模型的进一步精化是密不可分的。它通常需要更高级的设计技巧以及更严格的模型定义。

You will usually depend on creativity and trial and error to find good ways to model the concepts you discover, but sometimes someone has laid down a pattern you can follow. Chapters 11 and 12 discuss the application of “analysis patterns” and “design patterns.” Such patterns are not ready-made solutions, but they feed your knowledge crunching process and narrow your search.

> 你需要富有创造力，不断地尝试，不断地发现问题才能找到合适的方法为你所发现的领域概念建模，但有时你也可以借用别人已建好的模式。第 11 章和第 12 章将会讨论“分析模式”和“设计模式”的应用。这些模式并不是现成的解决方案，但是它们可以帮助我们消化领域知识并缩小研究范围。

But I’ll start Part III with the most exciting event in domain-driven design. Sometimes, when the stage is set with a MODEL-DRIVEN DESIGN and explicit concepts, you have a breakthrough. An opportunity opens up to transform your software into something more expressive and versatile than you expected. This can mean new features or it can just mean the replacement of a big chunk of rigid code with a simple, flexible expression of a deeper model. Although such breakthroughs don’t come along every day, they are so valuable that when they do happen, the opportunity needs to be recognized and grasped.

> 但是，让我们以领域驱动设计中最令人兴奋的事件来开始第三部分吧，那就是突破。有时，当我们拥有了 MODEL-DRIVEN DESIGN 和显式概念，就能够产生突破。我们有机会使软件更富表达力、更加多样化，甚至会使它变得超乎我们的想象。这可以为软件带来新特性，或者意味着我们可以用简单灵活的方式来表达更深层次的模型，从而替换掉大段死板的代码。尽管这种突破不会时常出现，但它们非常有价值，当我们有机会进行突破时，一定要懂得识别并抓住机会。

Chapter 8 tells the true story of a project on which a process of refactoring toward deeper insight led to a breakthrough. This experience is not something you can plan for. Nonetheless, it provides a good context for thinking about domain refactoring.

> 第 8 章讲述了一个真实的项目，这个项目通过重构过程得到了更深层的理解，最终实现了突破。这种经历是可遇而不可求的。尽管如此，它却为我们提供了一个很好的学习背景，帮助我们思考领域重构。
