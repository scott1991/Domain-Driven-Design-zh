# 第 4 章 分离领域

> Four. Isolating the Domain

The part of the software that specifically solves problems from the domain usually constitutes only a small portion of the entire software system, although its importance is disproportionate to its size. To apply our best thinking, we need to be able to look at the elements of our model and see them as a system. We must not be forced to pick them out of a much larger mix of objects, like trying to identify constellations in the night sky. We need to decouple the domain objects from other functions of the system, so we can avoid confusing the domain concepts with other concepts related only to software technology or losing sight of the domain altogether in the mass of the system.

> 在软件中，虽然专门用于解决领域问题的那部分通常只占整个软件系统的很小一部分，但其却出乎意料的重要。要想实现本书的想法，我们需要着眼于模型中的元素并且将它们视为一个系统。绝不能像在夜空中辨认星座一样，被迫从一大堆混杂的对象中将领域对象挑选出来。我们需要将领域对象与系统中的其他功能分离，这样就能够避免将领域概念和其他只与软件技术相关的概念搞混了，也不会在纷繁芜杂的系统中完全迷失了领域。

Sophisticated techniques for this isolation have emerged. This is well-trodden ground, but it is so critical to the successful application of domain-modeling principles that it must be reviewed briefly, from a domain-driven point of view. . . .

> 分离领域的复杂技术早已出现，而且都是我们耳熟能详的，但是它对于能否成功运用领域建模原则起着非常关键的作用，所以我们要从领域驱动的视角对它进行简要的回顾。

## 4.1 LAYERED ARCHITECTURE 模式：LAYERED ARCHITECTURE

Image
For a shipping application to support the simple user act of selecting a cargo’s destination from a list of cities, there must be program code that (1) draws a widget on the screen, (2) queries the database for all the possible cities, (3) interprets the user’s input and validates it, (4) associates the selected city with the cargo, and (5) commits the change to the database. All of this code is part of the same program, but only a little of it is related to the business of shipping.

> 在一个运输应用程序中，要想支持从城市列表中选择运送货物目的地这样的简单用户行为，程序代码必须包括：（1）在屏幕上绘制一个屏幕组件（widget）；（2）查询数据库，调出所有可能的城市；（3）解析并验证用户输入；（4）将所选城市与货物关联；（5）向数据库提交此次数据修改。上面所有的代码都在同一个程序中，但是只有一小部分代码与运输业务相关。

Software programs involve design and code to carry out many different kinds of tasks. They accept user input, carry out business logic, access databases, communicate over networks, display information to users, and so on. So the code involved in each program function can be substantial.

> 软件程序需要通过设计和编码来执行许多不同类型的任务。它们接收用户输入，执行业务逻辑，访问数据库，进行网络通信，向用户显示信息，等等。因此程序中的每个功能都可能需要大量的代码来实现。

In an object-oriented program, UI, database, and other support code often gets written directly into the business objects. Additional business logic is embedded in the behavior of UI widgets and database scripts. This happens because it is the easiest way to make things work, in the short run.

> 在面向对象的程序中，常常会在业务对象中直接写入用户界面、数据库访问等支持代码。而一些业务逻辑则会被嵌入到用户界面组件和数据库脚本中。这么做是为了以最简单的方式在短期内完成开发工作。

When the domain-related code is diffused through such a large amount of other code, it becomes extremely difficult to see and to reason about. Superficial changes to the UI can actually change business logic. To change a business rule may require meticulous tracing of UI code, database code, or other program elements. Implementing coherent, model-driven objects becomes impractical. Automated testing is awkward. With all the technologies and logic involved in each activity, a program must be kept very simple or it becomes impossible to understand.

> 如果与领域有关的代码分散在大量的其他代码之中，那么查看和分析领域代码就会变得异常困难。对用户界面的简单修改实际上很可能会改变业务逻辑，而要想调整业务规则也很可能需要对用户界面代码、数据库操作代码或者其他的程序元素进行仔细的筛查。这样就不太可能实现一致的、模型驱动的对象了，同时也会给自动化测试带来困难。考虑到程序中各个活动所涉及的大量逻辑和技术，程序本身必须简单明了，否则就会让人无法理解。

Creating programs that can handle very complex tasks calls for separation of concerns, allowing concentration on different parts of the design in isolation. At the same time, the intricate interactions within the system must be maintained in spite of the separation.

> 要想创建出能够处理复杂任务的程序，需要做到关注点分离——使设计中的每个部分都得到单独的关注。在分离的同时，也需要维持系统内部复杂的交互关系。

There are all sorts of ways a software system might be divided, but through experience and convention, the industry has converged on LAYERED ARCHITECTURES, and specifically a few fairly standard layers. The metaphor of layering is so widely used that it feels intuitive to most developers. Many good discussions of layering are available in the literature, sometimes in the format of a pattern (as in Buschmann et al. 1996, pp. 31–51). The essential principle is that any element of a layer depends only on other elements in the same layer or on elements of the layers “beneath” it. Communication upward must pass through some indirect mechanism, which I’ll discuss a little later.

> 软件系统有各种各样的划分方式，但是根据软件行业的经验和惯例，普遍采用 LAYEREDARCHITECTURE（分层架构），特别是有几个层基本上已成了标准层。分层这种隐喻被广泛采用，大多数开发人员都对其有着直观的认识。许多文献对 LAYERED ARCHITECTURE 也进行了充分的讨论，有些是以模式的形式给出的[Buschmann et al. 1996, pp.31-51]。LAYEREDARCHITECTURE 的基本原则是层中的任何元素都仅依赖于本层的其他元素或其下层的元素。向上的通信必须通过间接的方式进行，这些将在后面讨论。

The value of layers is that each specializes in a particular aspect of a computer program. This specialization allows more cohesive designs of each aspect, and it makes these designs much easier to interpret. Of course, it is vital to choose layers that isolate the most important cohesive design aspects. Again, experience and convention have led to some convergence. Although there are many variations, most successful architectures use some version of these four conceptual layers:

> 分层的价值在于每一层都只代表程序中的某一特定方面。这种限制使每个方面的设计都更具内聚性，更容易解释。当然，要分离出内聚设计中最重要的方面，选择恰当的分层方式是至关重要的。在这里，经验和惯例又一次为我们指明了方向。尽管 LAYERED ARCHITECTURE 的种类繁多，但是大多数成功的架构使用的都是下面这 4 个概念层的某种变体。

Image
Some projects don’t make a sharp distinction between the user interface and application layers. Others have multiple infrastructure layers. But it is the crucial separation of the domain layer that enables MODEL-DRIVEN DESIGN.

> 有些项目没有明显划分出用户界面层和应用层，而有些项目则有多个基础设施层。但是将领域层分离出来才是实现 MODEL-DRIVEN DESIGN 的关键。

Therefore:

Partition a complex program into layers. Develop a design within each layer that is cohesive and that depends only on the layers below. Follow standard architectural patterns to provide loose coupling to the layers above. Concentrate all the code related to the domain model in one layer and isolate it from the user interface, application, and infrastructure code. The domain objects, free of the responsibility of displaying themselves, storing themselves, managing application tasks, and so forth, can be focused on expressing the domain model. This allows a model to evolve to be rich enough and clear enough to capture essential business knowledge and put it to work.

> 给复杂的应用程序划分层次。在每一层内分别进行设计，使其具有内聚性并且只依赖于它的下层。采用标准的架构模式，只与上层进行松散的耦合。将所有与领域模型相关的代码放在一个层中，并把它与用户界面层、应用层以及基础设施层的代码分开。领域对象应该将重点放在如何表达领域模型上，而不需要考虑自己的显示和存储问题，也无需管理应用任务等内容。这使得模型的含义足够丰富，结构足够清晰，可以捕捉到基本的业务知识，并有效地使用这些知识。

Separating the domain layer from the infrastructure and user interface layers allows a much cleaner design of each layer. Isolated layers are much less expensive to maintain, because they tend to evolve at different rates and respond to different needs. The separation also helps with deployment in a distributed system, by allowing different layers to be placed flexibly in different servers or clients, in order to minimize communication overhead and improve performance (Fowler 1996).

> 将领域层与基础设施层以及用户界面层分离，可以使每层的设计更加清晰。彼此独立的层更容易维护，因为它们往往以不同的速度发展并且满足不同的需求。层与层的分离也有助于在分布式系统中部署程序，不同的层可以灵活地放在不同服务器或者客户端中，这样可以减少通信开销，并优化程序性能[Fowler 1996]。

Example: Partitioning Online Banking Functionality into Layers

> 示例为网上银行功能分层

An application provides various capabilities for maintaining bank accounts. One feature is funds transfer, in which the user enters or chooses two account numbers and an amount of money and then initiates a transfer.

> 该应用程序能提供维护银行账户的各种功能。其中一个功能就是转账，用户可以输入或者选择两个账户号码，填写要转的金额，然后开始转账。

To make this example manageable, I’ve omitted major technical features, most notably security. The domain design is also oversimplified. (Realistic complexity would only increase the need for layered architecture.) Furthermore, the particular infrastructure implied here is meant to be simple and obvious to make the example clear—it is not a suggested design. The responsibilities of the remaining functionality would be layered as shown in Figure 4.1.

> 为了让这个例子更容易实现，这里省略了一些主要的技术特性，特别是安全性方面的一些特性。领域设计也尽量简化。（在现实生活中，银行业务的复杂性只会增加对 LAYEREDARCHITECTURE 的需求。）此外，这个例子中的基础设施只是为了使程序更简单和清楚一些而已——我并不建议你使用这个设计。简化后的功能所要完成的任务将会按照图 4-1 来分层。

Image
Figure 4.1. Objects carry out responsibilities consistent with their layer and are more coupled to other objects in their layer.

Note that the domain layer, not the application layer, is responsible for fundamental business rules—in this case, the rule is “Every credit has a matching debit.”

> 注意，负责处理基本业务规则的是领域层，而不是应用层——在这个例子中，业务规则就是“每笔贷款必须有与其数目相同的借款”。

The application also makes no assumptions about the source of the transfer request. The program presumably includes a UI with entry fields for account numbers and amounts and with buttons for commands. But that user interface could be replaced by a wire request in XML without affecting the application layer or any of the lower layers. This decoupling is important not because projects frequently need to replace user interfaces with wire requests but because a clean separation of concerns keeps the design of each layer easy to understand and maintain.

> 这个应用程序没有设定转账请求的发起方。程序中假定包含了用户输入界面，界面中有账户号码和转账金额的输入字段以及一些命令按钮。但是也可以用基于 XML 的电汇请求来替换，这并不会影响应用层及其下面的各层。这种解耦至关重要，这并不是因为在项目中经常需要用电汇请求来代替用户界面，而是因为关注点的清晰分离可以使每一层的设计更易理解和维护。

In fact, Figure 4.1 itself mildly illustrates the problem of not isolating the domain. Because everything from the request to transaction control had to be included, the domain layer had to be dumbed down to keep the overall interaction simple enough to follow. If we were focused on the design of the isolated domain layer, we would have space on the page and in our heads for a model that better represented the domain’s rules, perhaps including ledgers, credit and debit objects, or monetary transaction objects.

> 事实上，图 4-1 本身也略微说明了不分离领域层会出现的问题。这张图需要包含从请求到事务控制的所有方面，所以不得不简化领域层来保证整个交互过程简单易懂。如果我们专注于研究独立领域层的设计，就可以构思并绘制出更好地表达领域规则的模型，也许模型中会包含分类账、贷款和借款对象，或者是现金交易对象。

### 4.1.1 Relating the Layers 将各层关联起来

So far the discussion has focused on the separation of layers and the way in which that partitioning improves the design of each aspect of the program, particularly the domain layer. But of course, the layers have to be connected. To do this without losing the benefit of the separation is the motivation behind a number of patterns.

> 到目前为止，我们的讨论主要集中在层次划分以及如何分层才能改进程序各个方面的设计上，特别是集中在领域层上。但是显然，各层之间也需要互相连接。在连接各层的同时不影响分离带来的好处，这是很多模式的目的所在。

Layers are meant to be loosely coupled, with design dependencies in only one direction. Upper layers can use or manipulate elements of lower ones straightforwardly by calling their public interfaces, holding references to them (at least temporarily), and generally using conventional means of interaction. But when an object of a lower level needs to communicate upward (beyond answering a direct query), we need another mechanism, drawing on architectural patterns for relating layers such as callbacks or OBSERVERS (Gamma et al. 1995).

> 各层之间是松散连接的，层与层的依赖关系只能是单向的。上层可以直接使用或操作下层元素，方法是通过调用下层元素的公共接口，保持对下层元素的引用（至少是暂时的），以及采用常规的交互手段。而如果下层元素需要与上层元素进行通信（不只是回应直接查询），则需要采用另一种通信机制，使用架构模式来连接上下层，如回调模式或 OBSERVERS 模式[Gamma et al.1995]。

The grandfather of patterns for connecting the UI to the application and domain layers is MODEL-VIEW-CONTROLLER (MVC). It was pioneered in the Smalltalk world back in the 1970s and has inspired many of the UI architectures that followed. Fowler (2003) discusses this pattern and several useful variations on the theme. Larman (1998) explores these concerns in the MODEL-VIEW SEPARATION PATTERN, and his APPLICATION COORDINATOR is one approach to connecting the application layer.

> 最早将用户界面层与应用层和领域层相连的模式是 MODEL-VIEW-CONTROLLER（MVC，模型—视图—控制器）框架。它是为 Smalltalk 语言发明的一种设计模式，创建于 20 世纪 70 年代。随后出现的许多用户界面架构都是受到它的启发而产生的。Fowler 在[Fowler 2002]中讨论了这种模式以及几个实用的变体。Larman 也在 MODEL-VIEW SEPARATION 模式中探讨了这些问题，他提出的 APPLICATION COORDINATOR（应用协调器）是连接应用层的一种方法[Larman1998]。

There are other styles of connecting the UI and the application. For our purposes, all approaches are fine as long as they maintain the isolation of the domain layer, allowing domain objects to be designed without simultaneously thinking about the user interface that might interact with them.

> 还有许多其他连接用户界面层和应用层的方式。对我们而言，只要连接方式能够维持领域层的独立性，保证在设计领域对象时不需要同时考虑可能与其交互的用户界面，那么这些连接方式就都是可用的。

The infrastructure layer usually does not initiate action in the domain layer. Being “below” the domain layer, it should have no specific knowledge of the domain it is serving. Indeed, such technical capabilities are most often offered as SERVICES. For example, if an application needs to send an e-mail, some message-sending interface can be located in the infrastructure layer and the application layer elements can request the transmission of the message. This decoupling gives some extra versatility. The message-sending interface might be connected to an e-mail sender, a fax sender, or whatever else is available. But the main benefit is simplifying the application layer, keeping it narrowly focused on its job: knowing when to send a message, but not burdened with how.

> 通常，基础设施层不会发起领域层中的操作，它处于领域层“之下”，不包含其所服务的领域中的知识。事实上这种技术能力最常以 SERVICE 的形式提供。例如，如果一个应用程序需要发送电子邮件，那么一些消息发送的接口可以放在基础设施层中，这样，应用层中的元素就可以请求发送消息了。这种解耦使程序的功能更加丰富。消息发送接口可以连接到电子邮件发送服务、传真发送服务或任何其他可用的服务。但是这种方式最主要的好处是简化了应用层，使其只专注于自己所负责的工作：知道何时该发送消息，而不用操心怎么发送。

The application and domain layers call on the SERVICES provided by the infrastructure layer. When the scope of a SERVICE has been well chosen and its interface well designed, the caller can remain loosely coupled and uncomplicated by the elaborate behavior the SERVICE interface encapsulates.

> 应用层和领域层可以调用基础设施层所提供的 SERVICE。如果 SERVICE 的范围选择合理，接口设计完善，那么通过把详细行为封装到服务接口中，调用程序就可以保持与 SERVICE 的松散连接，并且自身也会很简单。

But not all infrastructure comes in the form of SERVICES callable from the higher layers. Some technical components are designed to directly support the basic functions of other layers (such as providing an abstract base class for all domain objects) and provide the mechanisms for them to relate (such as implementations of MVC and the like). Such an “architectural framework” has much more impact on the design of the other parts of the program.

> 然而，并不是所有的基础设施都是以可供上层调用的 SERVICE 的形式出现的。有些技术组件被设计成直接支持其他层的基本功能（如为所有的领域对象提供抽象基类），并且提供关联机制（如 MVC 及类似框架的实现）。这种“架构框架”对于程序其他部分的设计有着更大的影响。

### 4.1.2 Architectural Frameworks 架构框架

When infrastructure is provided in the form of SERVICES called on through interfaces, it is fairly intuitive how the layering works and how to keep the layers loosely coupled. But some technical problems call for more intrusive forms of infrastructure. Frameworks that integrate many infrastructure needs often require the other layers to be implemented in very particular ways, for example as a subclass of a framework class or with structured method signatures. (It may seem counterintuitive for a subclass to be in a layer higher than that of the parent class, but keep in mind which class reflects more knowledge of the other.) The best architectural frameworks solve complex technical problems while allowing the domain developer to concentrate on expressing a model. But frameworks can easily get in the way, either by making too many assumptions that constrain domain design choices or by making the implementation so heavyweight that development slows down.

> 如果基础设施通过接口调用 SERVICE 的形式来实现，那么如何分层以及如何保持层与层之间的松散连接就是相当显而易见的。但是有些技术问题要求更具侵入性的基础设施。整合了大量基础设施需求的框架通常会要求其他层以某种特定的方式实现，如以框架类的子类形式或者带有结构化的方法签名。（子类在父类的上层似乎是违反常理的，但是要记住哪个类反映了另一个类的更多知识。）最好的架构框架既能解决复杂技术问题，也能让领域开发人员集中精力去表达模型，而不考虑其他问题。然而使用框架很容易为项目制造障碍：要么是设定了太多的假设，减小了领域设计的可选范围；要么是需要实现太多的东西，影响开发进度。

Some form of architectural framework usually is needed (though sometimes teams choose frameworks that don’t serve them well). When applying a framework, the team needs to focus on its goal: building an implementation that expresses a domain model and uses it to solve important problems. The team must seek ways of employing the framework to those ends, even if it means not using all of the framework’s features. For example, early J2EE applications often implemented all domain objects as “entity beans.” This approach bogged down both performance and the pace of development. Instead, current best practice is to use the J2EE framework for larger grain objects, implementing most business logic with generic Java objects. A lot of the downside of frameworks can be avoided by applying them selectively to solve difficult problems without looking for a one-size-fits-all solution. Judiciously applying only the most valuable of framework features reduces the coupling of the implementation and the framework, allowing more flexibility in later design decisions. More important, given how very complicated many of the current frameworks are to use, this minimalism helps keep the business objects readable and expressive.

> 项目中一般都需要某种形式的架构框架（尽管有时项目团队选择了不太合适的框架）。当使用框架时，项目团队应该明确其使用目的：建立一种可以表达领域模型的实现并且用它来解决重要问题。项目团队必须想方设法让框架满足这些需求，即使这意味着抛弃框架中的一些功能。例如，早期的 J2EE 应用程序通常都会将所有的领域对象实现为“实体 bean”。这种实现方式不但影响程序性能，还会减慢开发速度。现在，取而代之的最佳实践是利用 J2EE 框架来实现大粒度对象，而用普通 Java 对象来实现大部分的业务逻辑。不妄求万全之策，只要有选择性地运用框架来解决难点问题，就可以避开框架的很多不足之处。明智而审慎地选择框架中最具价值的功能能够减少程序实现和框架之间的耦合，使随后的设计决策更加灵活。更重要的是，现在许多框架的用法都极其复杂，这种简化方式有助于保持业务对象的可读性，使其更富有表达力。

Architectural frameworks and other tools will continue to evolve. Newer frameworks will automate or prefabricate more and more of the technical aspects of an application. If this is done right, application developers will increasingly concentrate their time on modeling the core business problems, greatly improving productivity and quality. But as we move in this direction, we must guard against our enthusiasm for technical solutions; elaborate frameworks can also straitjacket application developers.

> 架构框架和其他工具都在不断的发展。新框架将越来越多的应用技术问题变得自动化，或者为其提供了预先设定好的解决方案。如果框架使用得当，那么程序开发人员将可以更加专注于核心业务问题的建模工作，这会大大提高开发效率和程序质量。但与此同时，我们必须要保持克制，不要总是想着要寻找框架，因为精细的框架也可能会束缚住程序开发人员。

## 4.2 THE DOMAIN LAYER IS WHERE THE MODEL LIVES 领域层是模型的精髓

LAYERED ARCHITECTURE is used in most systems today, under various layering schemes. Many styles of development can also benefit from layering. However, domain-driven design requires only one particular layer to exist.

> 现在，大部分软件系统都采用了 LAYERED ARCHITECTURE，只是采用的分层方案存在不同而已。许多类型的开发工作都能从分层中受益。然而，领域驱动设计只需要一个特定的层存在即可。

The domain model is a set of concepts. The “domain layer” is the manifestation of that model and all directly related design elements. The design and implementation of business logic constitute the domain layer. In a MODEL-DRIVEN DESIGN, the software constructs of the domain layer mirror the model concepts.

> 领域模型是一系列概念的集合。“领域层”则是领域模型以及所有与其直接相关的设计元素的表现，它由业务逻辑的设计和实现组成。在 MODEL-DRIVEN DESIGN 中，领域层的软件构造反映出了模型概念。

It is not practical to achieve that correspondence when the domain logic is mixed with other concerns of the program. Isolating the domain implementation is a prerequisite for domain-driven design.

> 如果领域逻辑与程序中的其他关注点混在一起，就不可能实现这种一致性。将领域实现独立出来是领域驱动设计的前提。

## 4.3 THE SMART UI “ANTI-PATTERN” 模式：THE SMART UI“反模式”

. . . That sums up the widely accepted LAYERED ARCHITECTURE pattern for object applications. But this separation of UI, application, and domain is so often attempted and so seldom accomplished that its negation deserves a discussion in its own right.

> 上面总结了面向对象程序中广泛采用的 LAYERED ARCHITECTURE 模式。在项目中，人们经常会尝试分离用户界面、应用和领域，但是成功分离的却不多见，因此，分层模式的反面就很值得一谈。

Many software projects do take and should continue to take a much less sophisticated design approach that I call the SMART UI. But SMART UI is an alternate, mutually exclusive fork in the road, incompatible with the approach of domain-driven design. If that road is taken, most of what is in this book is not applicable. My interest is in the situations where the SMART UI does not apply, which is why I call it, with tongue in cheek, an “anti-pattern.” Discussing it here provides a useful contrast and will help clarify the circumstances that justify the more difficult path taken in the rest of the book.

> 许多软件项目都采用并且应该会继续采用一种不那么复杂的设计方法，我称其为 SMART UI（智能用户界面）。但是 SMART UI 是另一种设计方法，与领域驱动设计方法迥然不同且互不兼容。如果你选择了 SMART UI，那么本书中所讲的大部分内容都不适合你。我感兴趣的是那些不应该使用 SMART UI 的情况，这也是我半开玩笑地称其为“反模式”的原因。本节讨论 SMART UI 是为了提供一种有益的对比，其将帮助我们认清在本书后面章节中的哪些情况下需要选择相对而言更难于实现的领域驱动设计模式。

---

A project needs to deliver simple functionality, dominated by data entry and display, with few business rules. Staff is not composed of advanced object modelers.

> 假设一个项目只需要提供简单的功能，以数据输入和显示为主，涉及业务规则很少。项目团队也没有高级对象建模师。

If an unsophisticated team with a simple project decides to try a MODEL-DRIVEN DESIGN with LAYERED ARCHITECTURE, it will face a difficult learning curve. Team members will have to master complex new technologies and stumble through the process of learning object modeling (which is challenging, even with the help of this book!). The overhead of managing infrastructure and layers makes very simple tasks take longer. Simple projects come with short time lines and modest expectations. Long before the team completes the assigned task, much less demonstrates the exciting possibilities of its approach, the project will have been canceled.

> 如果一个经验并不丰富的项目团队要完成一个简单的项目，却决定使用 MODEL-DRIVENDESIGN 以及 LAYERED ARCHITECTURE，那么这个项目组将会经历一个艰难的学习过程。团队成员不得不去掌握复杂的新技术，艰难地学习对象建模。（即使有这本书的帮助，这也依然是一个具有挑战性的任务！）对基础设施和各层的管理工作使得原本简单的任务却要花费很长的时间来完成。简单项目的开发周期较短，期望值也不是很高。所以，早在项目团队完成任务之前，该项目就会被取消，更谈不上去论证有关这种方法的许多种令人激动的可行性了。

Even if the team is given more time, the team members are likely to fail to master the techniques without expert help. And in the end, if they do surmount these challenges, they will have produced a simple system. Rich capabilities were never requested.

> 即使项目有更充裕的时间，如果没有专家的帮助，团队成员也不太可能掌握这些技术。最后，假如他们确实能够克服这些困难，恐怕也只会开发出一套简单的系统。因为这个项目本来就不需要丰富的功能。

A more experienced team would not face the same trade-offs. Seasoned developers could flatten the learning curve and compress the time needed to manage the layers. Domain-driven design pays off best for ambitious projects, and it does require strong skills. Not all projects are ambitious. Not all project teams can muster those skills.

> 经验丰富的团队则不会做出这样的选择。身经百战的开发人员能够更容易学习，进而减少管理各层所需要的时间。领域驱动设计只有应用在大型项目上才能产生最大的收益，而这也确实需要高超的技巧。不是所有的项目都是大型项目；也不是所有的项目团队都能掌握那些技巧。

Therefore, when circumstances warrant:

> 因此，当情况需要时：

Put all the business logic into the user interface. Chop the application into small functions and implement them as separate user interfaces, embedding the business rules into them. Use a relational database as a shared repository of the data. Use the most automated UI building and visual programming tools available.

> 在用户界面中实现所有的业务逻辑。将应用程序分成小的功能模块，分别将它们实现成用户界面，并在其中嵌入业务规则。用关系数据库作为共享的数据存储库。使用自动化程度最高的用户界面创建工具和可用的可视化编程工具。

Heresy! The gospel (as advocated everywhere, including elsewhere in this book) is that domain and UI should be separate. In fact, it is difficult to apply any of the methods discussed later in this book without that separation, and so this SMART UI can be considered an “anti-pattern” in the context of domain-driven design. Yet it is a legitimate pattern in some other contexts. In truth, there are advantages to the SMART UI, and there are situations where it works best—which partially accounts for why it is so common. Considering it here helps us understand why we need to separate application from domain and, importantly, when we might not want to.

> 这真是异端邪说啊！福音（所有地方，包括本书其他地方，都在倡导的原则）说应该是领域和 UI 彼此独立。事实上，不将领域和用户界面分离，则很难运用本书后面所要讨论的方法，因此在领域驱动设计中，可以将 SMART UI 看作是“反模式”。然而在其他情况下，它也是完全可行的。其实，SMART UI 也有其自身的优势，在某些情况下它能发挥最佳的作用——这也是它如此普及的原因之一。在这里介绍 SMART UI 能够帮助我们理解为什么需要将应用程序与领域分离，而且更重要的是，还能让我们知道什么时候不需要这样做。

Advantages

- Productivity is high and immediate for simple applications.
- Less capable developers can work this way with little training.
- Even deficiencies in requirements analysis can be overcome by releasing a prototype to users and then quickly changing the product to fit their requests.
- Applications are decoupled from each other, so that delivery schedules of small modules can be planned relatively accurately. Expanding the system with additional, simple behavior can be easy.
- Relational databases work well and provide integration at the data level.
- 4GL tools work well.
- When applications are handed off, maintenance programmers will be able to quickly redo portions they can’t figure out, because the effects of the changes should be localized to each particular UI.

---

> - 效率高，能在短时间内实现简单的应用程序。
> - 能力较差的开发人员可以几乎不经过培训就采用它。
> - 甚至可以克服需求分析上的不足，只要把原型发布给用户，然后根据用户反馈快速修改软件产品即可。
> - 程序之间彼此独立，这样，可以相对准确地安排小模块交付的日期。额外扩展简单的功能也很容易。
> - 可以很顺利地使用关系数据库，能够提供数据级的整合。
> - 可以使用第四代语言工具。
> - 移交应用程序后，维护程序员可以迅速重写他们不明白的代码段，因为修改代码只会影响到代码所在的用户界面。

Disadvantages

- Integration of applications is difficult except through the database.
- There is no reuse of behavior and no abstraction of the business problem. Business rules have to be duplicated in each operation to which they apply.
- Rapid prototyping and iteration reach a natural limit because the lack of abstraction limits refactoring options.
- Complexity buries you quickly, so the growth path is strictly toward additional simple applications. There is no graceful path to richer behavior.

---

> - 不通过数据库很难集成应用模块。
> - 没有对行为的重用，也没有对业务问题的抽象。每当操作用到业务规则时，都必须重复这些规则。
> - 快速的原型建立和迭代很快会达到其极限，因为抽象的缺乏限制了重构的选择。
> - 复杂的功能很快会让你无所适从，所以程序的扩展只能是增加简单的应用模块，没有很好的办法来实现更丰富的功能。

If this pattern is applied consciously, a team can avoid taking on a great deal of overhead required by other approaches. It is a common mistake to undertake a sophisticated design approach that the team isn’t committed to carrying all the way through. Another common, costly mistake is to build a complex infrastructure and use industrial-strength tools for a project that doesn’t need them.

> 如果项目团队有意识地应用这个模式，那么就可以避免其他方法所需要的大量开销。项目团队常犯的错误是采用了一种复杂的设计方法，却无法保证项目从头到尾始终使用它。另一种常见的也是代价高昂的错误则是为项目构建一种复杂的基础设施以及使用工业级的工具，而这样的项目根本不需要它们。

Most flexible languages (such as Java) are overkill for these applications and will cost dearly. A 4GL-style tool is the way to go.

> 大部分灵活的编程语言（如 Java）对于小型应用程序来说是大材小用了，并且使用它们的开销很大。第四代语言风格的工具就足以满足这种需要了。

Remember, one of the consequences of this pattern is that you can’t migrate to another design approach except by replacing entire applications. Just using a general-purpose language such as Java won’t really put you in a position to later abandon the SMART UI, so if you’ve chosen that path, you should choose development tools geared to it. Don’t bother hedging your bet. Just using a flexible language doesn’t create a flexible system, but it may well produce an expensive one.

> 记住，在项目中使用智能用户界面后，除非重写全部的应用模块，否则不能改用其他的设计方法。使用诸如 Java 这类的通用语言并不能让你在随后的开发过程中放弃使用 SMART UI，因此，如果你选择了这条路线，就应该采用与之匹配的开发工具。不要浪费时间去同时采用多种选择。只使用灵活的编程语言并不一定会创建出灵活的软件系统，反而有可能会开发出一个维护代价十分高昂的系统。

By the same token, a team committed to a MODEL-DRIVEN DESIGN needs to design that way from the outset. Of course, even experienced project teams with big ambitions have to start with simple functionality and work their way up through successive iterations. But those first tentative steps will be MODEL-DRIVEN with an isolated domain layer, or the project will most likely be stuck with a SMART UI.

> 同样道理，采用 MODEL-DRIVEN DESIGN 的项目团队从项目初始就应该采用模型驱动的设计。当然，即使是经验丰富的项目团队在开发大型软件系统时，也不得不从简单的功能着手，然后在整个开发过程中使用连续的迭代开发。但是最初试探性的工作也应该是由模型驱动的，而且要分离出独立的领域层，否则很有可能项目进行到最后就变成智能用户界面模式了。

---

The SMART UI is discussed only to clarify why and when a pattern such as LAYERED ARCHITECTURE is needed in order to isolate a domain layer.

> 这里讨论 SMART UI 只是为了让你认清为什么以及何时需要采用诸如 LAYERED ARCHITECT-URE 这样的模式来分离出领域层。

There are other solutions in between SMART UI and LAYERED ARCHITECTURE. For example, Fowler (2003) describes the TRANSACTION SCRIPT, which separates UI from application but does not provide for an object model. The bottom line is this: If the architecture isolates the domain-related code in a way that allows a cohesive domain design loosely coupled to the rest of the system, then that architecture can probably support domain-driven design.

> 除 SMART UI 和 LAYERED ARCHITECTURE 之外，还有一些其他的设计方案。例如，Fowler 在[Fowler 2002]中描述了 TRANSACTION SCRIDT（事务脚本），它将用户界面从应用中分离出来，但却并不提供对象模型。总而言之：如果一个架构能够把那些与领域相关的代码隔离出来，得到一个内聚的领域设计，同时又使领域与系统其他部分保持松散耦合，那么这种架构也许可以支持领域驱动设计。

Other development styles have their place, but you must accept varying limits on complexity and flexibility. Failing to decouple the domain design can really be disastrous in certain settings. If you have a complex application and are committing to MODEL-DRIVEN DESIGN, bite the bullet, get the necessary experts, and avoid the SMART UI.

> 其他的开发风格也有各自的用武之地，但是必须要考虑到各种对于复杂度和灵活性的限制。在某些条件下，将领域设计与其他部分混在一起会产生灾难性的后果。如果你要开发复杂应用软件并且决定使用 MODEL-DRIVEN DESIGN，那么做好准备，咬紧牙关，雇用必不可少的专家，并且不要使用 SMART UI。

## 4.4 OTHER KINDS OF ISOLATION 其他分离方式

Unfortunately, there are influences other than infrastructure and user interfaces that can corrupt your delicate domain model. You must deal with other domain components that are not fully integrated into your model. You have to cope with other development teams who use different models of the same domain. These and other factors can blur your model and rob it of its utility. Chapter 14, “Maintaining Model Integrity,” deals with this topic, introducing such patterns as BOUNDED CONTEXT and ANTICORRUPTION LAYER. A really complicated domain model can become unwieldy all by itself. Chapter 15, “Distillation,” discusses how to make distinctions within the domain layer that can unencumber the essential concepts of the domain from peripheral detail.

> 遗憾的是，除了基础设施和用户界面之外，还有一些其他的因素也会破坏你精心设计的领域模型。你必须要考虑那些没有完全集成到模型中的领域元素。你不得不与同一领域中使用不同模型的其他开发团队合作。还有其他的因素会让你的模型结构不再清晰，并且影响模型的使用效率。在第 14 章中，会讨论这方面的问题，同时会介绍其他模式，如 BOUNDED CONTEXT 和 ANTICORRUPTION LAYER。非常复杂的领域模型本身是难以使用的，所以，第 15 章将会说明如何在领域层内进行进一步区分，以便从次要细节中突显出领域的核心概念。

But all that comes later. Next, we’ll look at the nuts and bolts of co-evolving an effective domain model and an expressive implementation. After all, the best part of isolating the domain is getting all that other stuff out of the way so that we can really focus on the domain design.

> 但是，这些都是后话。接下来，我们将会讨论一些具体细节，即如何让一个有效的领域模型和一个富有表达力的实现同时演进。毕竟，把领域隔离出来的最大好处就是可以真正专注于领域设计，而不用考虑其他的方面。
