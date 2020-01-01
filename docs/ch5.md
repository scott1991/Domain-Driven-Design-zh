# 第 5 章 软件中所表示的模型

> Five. A Model Expressed in Software

To compromise in implementation without losing the punch of a MODEL-DRIVEN DESIGN requires a reframing of the basics. Connecting model and implementation has to be done at the detail level. This chapter focuses on those individual model elements, getting them in shape to support the activities in later chapters.

> 要想在不削弱模型驱动设计能力的前提下对实现做出一些折中，需要重新组织基本元素。我们需要将模型与实现的各个细节一一联系起来。本章主要讨论这些基本模型元素并理解它们，以便为后面章节的讨论打好基础。

This discussion will start with the issues of designing and streamlining associations. Associations between objects are simple to conceive and to draw, but implementing them is a potential quagmire. Associations illustrate how crucial detailed implementation decisions are to the viability of a MODEL-DRIVEN DESIGN.

> 本章的讨论从如何设计和简化关联开始。对象之间的关联很容易想出来，也很容易画出来，但实现它们却存在很多潜在的麻烦。关联也表明了具体的实现决策在MODEL-DRIVEN DESIGN中的重要性。

Turning to the objects themselves, but continuing to scrutinize the relationship between detailed model choices and implementation concerns, we’ll focus on making distinctions among the three patterns of model elements that express the model: ENTITIES, VALUE OBJECTS, and SERVICES.

> 本章的讨论将侧重于模型本身，但仍继续仔细考查具体模型选择与实现问题之间的关系，我们将着重区分用于表示模型的3种模型元素模式：ENTITY、VALUE OBJECT和SERVICE。

Defining objects that capture concepts of the domain seems very intuitive on the surface, but serious challenges are lurking in the shades of meaning. Certain distinctions have emerged that clarify the meaning of model elements and tie into a body of design practices for carving out specific kinds of objects.

> 从表面上看，定义那些用来捕获领域概念的对象很容易，但要想反映其含义却很困难。这要求我们明确区分各种模型元素的含义，并与一系列设计实践结合起来，从而开发出特定类型的对象。

Does an object represent something with continuity and identity—something that is tracked through different states or even across different implementations? Or is it an attribute that describes the state of something else? This is the basic distinction between an ENTITY and a VALUE OBJECT. Defining objects that clearly follow one pattern or the other makes the objects less ambiguous and lays out the path toward specific choices for robust design.

> 一个对象是用来表示某种具有连续性和标识的事物的呢（可以跟踪它所经历的不同状态，甚至可以跨不同的实现跟踪它），还是用于描述某种状态的属性呢？这是ENTITY与VALUE OBJECT之间的根本区别。明确地选择这两种模式中的一个来定义对象，有利于减少歧义，并帮助我们做出特定的选择，这样才能得到健壮的设计。

Then there are those aspects of the domain that are more clearly expressed as actions or operations, rather than as objects. Although it is a slight departure from object-oriented modeling tradition, it is often best to express these as SERVICES, rather than forcing responsibility for an operation onto some ENTITY or VALUE OBJECT. A SERVICE is something that is done for a client on request. In the technical layers of the software, there are many SERVICES. They emerge in the domain also, when some activity is modeled that corresponds to something the software must do, but does not correspond with state.

> 领域中还有一些方面适合用动作或操作来表示，这比用对象表示更加清楚。这些方面最好用SERVICE来表示，而不应把操作的责任强加到ENTITY或VALUE OBJECT上，尽管这样做稍微违背了面向对象的建模传统。SERVICE是应客户端请求来完成某事。在软件的技术层中有很多SERVICE。在领域中也可以使用SERVICE，当对软件要做的某项无状态的活动进行建模时，就可以将该活动作为一项SERVICE。

There are inevitable situations in which the purity of the object model must be compromised, such as for storage in a relational database. This chapter will lay out some guidelines for staying on course when you are forced to deal with these messy realities.

> 在有些情况下（例如，为了将对象存储在关系数据库中）我们不得不对对象模型做一些折中改变，虽然这会影响对象模型的纯度。本章将给出一些指导原则，以便在被迫处理这种复杂局面时保持正确的方向。

Finally, a discussion of MODULES will drive home the point that every design decision should be motivated by some insight into the domain. The ideas of high cohesion and low coupling, often thought of as technical metrics, can be applied to the concepts themselves. In a MODEL-DRIVEN DESIGN, MODULES are part of the model, and they should reflect concepts in the domain.

> 最后，MODULE的讨论将有助于理解这样一个要点——每个设计决策都应该是在深入理解领域中的某些深层知识之后做出的。高内聚、低耦合这种思想（通常被认为是一种技术指标）可应用于概念本身。在MODEL-DRIVEN DESIGN中，MODULE是模型的一部分，它们应该反映领域中的概念。

This chapter brings together all of these building blocks, which embody the model in software. These ideas are conventional, and the modeling and design biases that follow from them have been written about before. But framing them in this context will help developers create detailed components that will serve the priorities of domain-driven design when tackling the larger model and design issues. Also, a sense of the basic principles will help developers stay on course through the inevitable compromises.

> 本章将所有这些体现软件模型的构造块组织到一起。这些都是一些传统思想，而且一些书籍中已经介绍过从中产生的建模和设计思想。但将这些思想组织到模型驱动开发的上下文中，可以帮助开发人员创建符合领域驱动设计主要原则的具体组件，从而有助于解决更大的模型和设计问题。此外，掌握这些基本原则可以帮助开发人员在被迫做出折中设计时把握好正确的方向。

## 5.1 ASSOCIATIONS 关联
The interaction between modeling and implementation is particularly tricky with the associations between objects.

> 对象之间的关联使得建模与实现之间的交互更为复杂。

For every traversable association in the model, there is a mechanism in the software with the same properties.

> 模型中每个可遍历的关联，软件中都要有同样属性的机制。

A model that shows an association between a customer and a sales representative corresponds to two things. On one hand, it abstracts a relationship developers deemed relevant between two real people. On the other hand, it corresponds to an object pointer between two Java objects, or an encapsulation of a database lookup, or some comparable implementation.

> 一个显示了顾客与销售代表之间关联的模型有两个含义。一方面，它把开发人员所认为的两个真实的人之间的关系抽象出来。另一方面，它相当于两个Java对象之间的对象指针，或者相当于数据库查询（或类似实现）的一种封装。

For example, a one-to-many association might be implemented as a collection in an instance variable. But the design is not necessarily so direct. There may be no collection; an accessor method may query a database to find the appropriate records and instantiate objects based on them. Both of these designs would reflect the same model. The design has to specify a particular traversal mechanism whose behavior is consistent with the association in the model.

> 例如，一对多关联可以用一个集合类型的实例变量来实现。但设计无需如此直接。可能没有集合，这时可以使用一个访问方法（accessor method）来查询数据库，找到相应的记录，并用这些记录来实例化对象。这两种设计方法反映了同一个模型。设计必须指定一种具体的遍历机制，这种遍历的行为应该与模型中的关联一致。

In real life, there are lots of many-to-many associations, and a great number are naturally bidirectional. The same tends to be true of early forms of a model as we brainstorm and explore the domain. But these general associations complicate implementation and maintenance. Furthermore, they communicate very little about the nature of the relationship.

> 现实生活中有大量“多对多”关联，其中有很多关联天生就是双向的。我们在模型开发的早期进行头脑风暴活动并探索领域时，也会得到很多这样的关联。但这些普遍的关联会使实现和维护变得很复杂。此外，它们也很少能表示出关系的本质。

There are at least three ways of making associations more tractable.

> 至少有3种方法可以使得关联更易于控制。

1. Imposing a traversal direction
2. Adding a qualifier, effectively reducing multiplicity
3. Eliminating nonessential associations

---


> 1. 规定一个遍历方向。
> 2. 添加一个限定符，以便有效地减少多重关联。
> 3. 消除不必要的关联。

It is important to constrain relationships as much as possible. A bidirectional association means that both objects can be understood only together. When application requirements do not call for traversal in both directions, adding a traversal direction reduces interdependence and simplifies the design. Understanding the domain may reveal a natural directional bias.

> 尽可能地对关系进行约束是非常重要的。双向关联意味着只有将这两个对象放在一起考虑才能理解它们。当应用程序不要求双向遍历时，可以指定一个遍历方向，以便减少相互依赖，并简化设计。理解了领域之后就可以自然地确定一个方向。

The United States has had many presidents, as have many other countries. This is a bidirectional, one-to-many relationship. Yet we seldom would start out with the name “George Washington” and ask, “Of which country was he president?” Pragmatically, we can reduce the relationship to a unidirectional association, traversable from country to president. This refinement actually reflects insight into the domain, as well as making a more practical design. It captures the understanding that one direction of the association is much more meaningful and important than the other. It keeps the “Person” class independent of the far less fundamental concept of “President.”

> 像很多国家一样，美国有过很多位总统。这是一种双向的、一对多的关系。然而，在提到“乔治·华盛顿”这个名字时，我们很少会问“他是哪个国家的总统？”。从实用的角度讲，我们可以将这种关系简化为从国家到总统的单向关联。如图5-1所示。这种精化实际上反映了对领域的深入理解，而且也是一个更实用的设计。它表明一个方向的关联比另一个方向的关联更有意义且更重要。也使得Person类不受非基本概念President的束缚。

<Figures figure="5-1">Some traversal directions reflect a natural bias in the domain.</Figures>

Very often, deeper understanding leads to a “qualified” relationship. Looking deeper into presidents, we realize that (except in a civil war, perhaps) a country has only one president at a time. This qualifier reduces the multiplicity to one-to-one, and explicitly embeds an important rule into the model. Who was president of the United States in 1790? George Washington.

> 通常，通过更深入的理解可以得到一个“限定的”关系。进一步研究总统的例子就可以知道，一个国家在一段时期内只能有一位总统（内战期间或许有例外）。这个限定条件把多重关系简化为一对一关系，并且在模型中植入了一条明确的规则。如图5-2所示。1790年谁是美国总统？乔治·华盛顿。

<Figures figure="5-2">Constrained associations communicate more knowledge and are more practical designs.</Figures>

Constraining the traversal direction of a many-to-many association effectively reduces its implementation to one-to-many—a much easier design.

> 限定多对多关联的遍历方向可以有效地将其实现简化为一对多关联，从而得到一个简单得多的设计。

Consistently constraining associations in ways that reflect the bias of the domain not only makes those associations more communicative and simpler to implement, it also gives significance to the remaining bidirectional associations. When the bidirectionality of a relationship is a semantic characteristic of the domain, when it’s needed for application functionality, the retention of both traversal directions conveys that.

> 坚持将关联限定为领域所倾向的方向，不仅可以提高这些关联的表达力并简化其实现，而且还可以突出剩下的双向关联的重要性。当双向关联是领域的一个语义特征时，或者当应用程序的功能要求双向关联时，就需要保留它，以便表达出这些需求。

Of course, the ultimate simplification is to eliminate an association altogether, if it is not essential to the job at hand or the fundamental meaning of the model objects.

> 当然，最终的简化是清除那些对当前工作或模型对象的基本含义来说不重要的关联。

Example: Associations in a Brokerage Account

> 示例Brokerage Account（经纪账户）中的关联

<Figures figure="5-3"></Figures>

One Java implementation of Brokerage Account in this model would be

> 此模型中的Brokerage Account的一个Java实现如下：
```java
public class BrokerageAccount {
    String accountNumber;
    Customer customer;
    Set investments;
  // Constructors, etc. omitted

  public Customer getCustomer() {
    return customer;
  }
  public Set getInvestments() {
    return investments;
  }
}
```

But if we need to fetch the data from a relational database, another implementation, equally consistent with the model, would be the following:

> 但是，如果需要从关系数据库取回数据，那么就可以使用另一种实现（它同样也符合模型）：

Table: BROKERAGE_ACCOUNT

Image
Table: CUSTOMER

Image
Table: INVESTMENT

Image
```java
public class BrokerageAccount {
  String accountNumber;
  String customerSocialSecurityNumber;

  // Omit constructors, etc.

  public Customer getCustomer() {
    String sqlQuery =
      "SELECT * FROM CUSTOMER WHERE" +
      "SS_NUMBER='"+customerSocialSecurityNumber+"'";
    return QueryService.findSingleCustomerFor(sqlQuery);
  }
  public Set getInvestments() {
    String sqlQuery =
      "SELECT * FROM INVESTMENT WHERE" +
      "BROKERAGE_ACCOUNT='"+accountNumber+"'";
    return QueryService.findInvestmentsFor(sqlQuery);
  }
}
```
(Note: The QueryService, a utility for fetching rows from the database and creating objects, is simple for explaining examples, but it’s not necessarily a good design for a real project.)

> （注意：QueryService是一个实用类，它从数据库中取回数据行（row）并创建对象，这里使用它是为了让示例简单，但这在实际项目中可不一定是个好的设计。）

Let’s refine the model by qualifying the association between Brokerage Account and Investment, reducing its multiplicity. This says there can be only one investment per stock.

> 下面，我们通过限定Brokerage Account（经纪账户）与Investment（投资）之间的关联来简化其多重性，从而对模型进行精化。具体的限定是：每支股票只能对应于一笔投资，如图5-4所示。

<Figures figure="5-4"></Figures>

This wouldn’t be true of all business situations (for example, if the lots need to be tracked), but whatever the particular rules, as constraints on associations are discovered they should be included in the model and implementation. They make the model more precise and the implementation easier to maintain.

> 这种简化并不适合所有的业务情形（例如，当所有投资都要可追踪时），但不管是什么特殊规则，只要发现了关联的约束，就应该将这些约束添加到模型和实现中。它们可以使模型更精确，使实现更易于维护。

The Java implementation could become:

> 现在，Java实现变成下面这样：

```java
public class BrokerageAccount {
  String accountNumber;
  Customer customer;
  Map investments;

  // Omitting constructors, etc.

  public Customer getCustomer() {
    return customer;
  }
  public Investment getInvestment(String stockSymbol) {
    return (Investment)investments.get(stockSymbol);
  }
}
```
And an SQL-based implementation would be:

> 基于SQL的实现如下：

```java
public class BrokerageAccount {
  String accountNumber;
  String customerSocialSecurityNumber;

  //Omitting constructors, etc.
  public Customer getCustomer() {
    String sqlQuery = "SELECT * FROM CUSTOMER WHERE SS_NUMBER='"
      + customerSocialSecurityNumber + "'";
    return QueryService.findSingleCustomerFor(sqlQuery);
  }
  public Investment getInvestment(String stockSymbol) {
    String sqlQuery = "SELECT * FROM INVESTMENT "
      + "WHERE BROKERAGE_ACCOUNT='" + accountNumber + "'"
      + "AND STOCK_SYMBOL='" + stockSymbol +"'";
    return QueryService.findInvestmentFor(sqlQuery);

  }
}
```
Carefully distilling and constraining the model’s associations will take you a long way toward a MODEL-DRIVEN DESIGN. Now let’s turn to the objects themselves. Certain distinctions clarify the model while making for a more practical implementation. . . .

> 从仔细地简化和约束模型的关联到MODEL-DRIVEN DESIGN，还有一段漫长的探索过程。现在我们转向对象本身。仔细区分对象可以使得模型更加清晰，并得到更实用的实现。
> 
## 5.2 ENTITIES (A.K.A. REFERENCE OBJECTS) 模式：ENTITY（又称为REFERENCE OBJECT）
Image
Many objects are not fundamentally defined by their attributes, but rather by a thread of continuity and identity.

> 很多对象不是通过它们的属性定义的，而是通过连续性和标识定义的。

---

A landlady sued me, claiming major damages to her property. The papers I was served described an apartment with holes in the walls, stains on the carpet, and a noxious liquid in the sink that gave off caustic fumes that had made the kitchen wallpaper peel. The court documents named me as the tenant responsible for the damages, identifying me by name and by my then-current address. This was confusing to me, because I had never even visited that ruined place.

> 一位女房东起诉了我，要求我赔偿她房屋的大部分损失。诉状上是这样写的：房间的墙上有很多小洞，地毯上满是污渍，水池里的脏物散发出的腐蚀性气体导致厨房墙皮脱落。法庭文件认定我作为承租人应该为这些损失负责，依据就是我的名字和我当时的地址。这把我完全搞糊涂了，因为我从未去过那个被损坏的房子。

After a moment, I realized that it must be a case of mistaken identity. I called the plaintiff and told her this, but she didn’t believe me. The former tenant had been eluding her for months. How could I prove that I was not the same person who had cost her so much money? I was the only Eric Evans in the phone book.

> 过了一会儿，我意识到这一定是认错人了。我给原告打电话，告诉她这一点，但她并不相信我。几个月以来，上一位租客一直在躲避她。如何才能证明我不是那个破坏她房屋的人呢？现在电话簿里只有一个Eric Evans名字，那就是我。

Well, the phone book turned out to be my salvation. Because I had been living in the same apartment for two years, I asked her if she still had the previous year’s book. After she found it and verified that my listing was the same (right next to my namesake’s listing), she realized that I was not the person she wanted to sue, apologized, and promised to drop the case.

> 还是电话簿成了我的救星。由于我在这所公寓里已经住了两年，于是我问她是否还有去年的电话簿。她找到了电话簿，发现有与我同名的人（我就在那个人下面），她意识到我不是她要起诉的那个人，于是向我道歉，并答应撤销起诉。

Computers are not that resourceful. A case of mistaken identity in a software system leads to data corruption and program errors.

> 计算机可不会这么“足智多谋”。软件系统中的错误标识将导致数据破坏和程序错误。

There are special technical challenges here, which I’ll discuss in a bit, but first let’s look at the fundamental issue: Many things are defined by their identity, and not by any attribute. In our typical conception, a person (to continue with the nontechnical example) has an identity that stretches from birth to death and even beyond. That person’s physical attributes transform and ultimately disappear. The name may change. Financial relationships come and go. There is not a single attribute of a person that cannot change; yet the identity persists. Am I the same person I was at age five? This kind of metaphysical question is important in the search for effective domain models. Slightly rephrased: Does the user of the application care if I am the same person I was at age five?

> 这里存在一些特殊的技术挑战，我们稍后将会稍加说明，这里先来看一下基本问题。很多事物是由它们的标识定义的，而不是由任何属性定义的。我们一般会认为，一个人（继续使用非技术示例）有一个标识，这个标识会陪伴他走完一生（甚至死后）。这个人的物理属性会发生变化，最后消失。他的名字可能改变，财务关系也会发生变化，没有哪个属性是一生不变的，但标识却是永久的。我跟我5岁时是同一个人吗？这种听上去像是纯哲学的问题在探索有效的领域模型时非常重要。稍微变换一下问题的角度：应用程序的用户是否关心现在的我和5岁时的我是不是同一个人？

In a software system for tracking accounts due, that modest “customer” object may have a more colorful side. It accumulates status by prompt payment or is turned over to a bill-collection agency for failure to pay. It may lead a double life in another system altogether when the sales force extracts customer data into its contact management software. In any case, it is unceremoniously squashed flat to be stored in a database table. When new business stops flowing from that source, the customer object will be retired to an archive, a shadow of its former self.

> 在一个跟踪到期应收账款的软件系统中，即便最普通的“客户”对象也可能具有丰富多彩的一面。如果按时付款的话客户信用就会提高，如果未能付款则将其移交给账单清缴机构。当销售人员将客户数据提取出来，并放到联系人管理软件中时，“客户”对象在这个系统中就开始了另一种生活。无论是哪种情况，它都会被扁平化以存储在数据库表中。当业务最终停摆的时候，客户对象就“退休”了，变成归档状态，成为先前自己的一个影子。

Each of these forms of the customer is a different implementation based on a different programming language and technology. But when a phone call comes in with an order, it is important to know: Is this the customer who has the delinquent account? Is this the customer that Jack (a particular sales representative) has been working with for weeks? Is this a completely new customer?

> 客户对象的这些形式都是基于不同编程语言和技术的不同实现。但当接到订单电话时，知道以下事情是很重要的：这个客户是不是那个拖欠了账务的客户？这个客户是不是那个已经与Jack（一位销售代表）保持联络达好几个星期的客户？还是说他完全是一个新客户？

A conceptual identity has to be matched between multiple implementations of the objects, its stored forms, and real-world actors such as the phone caller. Attributes may not match. A sales representative may have entered an address update into the contact software, which is just being propagated to accounts due. Two customer contacts may have the same name. In distributed software, multiple users could be entering data from different sources, causing update transactions to propagate through the system to be reconciled in different databases asynchronously.

> 在对象的多个实现、存储形式和真实世界的参与者（如打电话的人）之间，概念性标识必须是匹配的。属性可以不匹配，例如，销售代表可能已经在联系软件中更新了地址，而这个更新正在传送给到期应收账款软件。两个客户可能同名。在分布式软件中，多个用户可能从不同地点输入数据，这需要在不同的数据库中异步地协调这些更新事务，使它们传播到整个系统。

Object modeling tends to lead us to focus on the attributes of an object, but the fundamental concept of an ENTITY is an abstract continuity threading through a life cycle and even passing through multiple forms.

> 对象建模有可能把我们的注意力引到对象的属性上，但实体的基本概念是一种贯穿整个生命周期（甚至会经历多种形式）的抽象的连续性。

Some objects are not defined primarily by their attributes. They represent a thread of identity that runs through time and often across distinct representations. Sometimes such an object must be matched with another object even though attributes differ. An object must be distinguished from other objects even though they might have the same attributes. Mistaken identity can lead to data corruption.

> 一些对象主要不是由它们的属性定义的。它们实际上表示了一条“标识线”（A Thread ofIdentity），这条线跨越时间，而且常常经历多种不同的表示。有时，这样的对象必须与另一个具有不同属性的对象相匹配。而有时一个对象必须与具有相同属性的另一个对象区分开。错误的标识可能会破坏数据。

An object defined primarily by its identity is called an ENTITY.1 ENTITIES have special modeling and design considerations. They have life cycles that can radically change their form and content, but a thread of continuity must be maintained. Their identities must be defined so that they can be effectively tracked. Their class definitions, responsibilities, attributes, and associations should revolve around who they are, rather than the particular attributes they carry. Even for ENTITIES that don’t transform so radically or have such complicated life cycles, placing them in the semantic category leads to more lucid models and more robust implementations.

> 主要由标识定义的对象被称作ENTITY[插图]。ENTITY（实体）有特殊的建模和设计思路。它们具有生命周期，这期间它们的形式和内容可能发生根本改变，但必须保持一种内在的连续性。为了有效地跟踪这些对象，必须定义它们的标识。它们的类定义、职责、属性和关联必须由其标识来决定，而不依赖于其所具有的属性。即使对于那些不发生根本变化或者生命周期不太复杂的ENTITY，也应该在语义上把它们作为ENTITY来对待，这样可以得到更清晰的模型和更健壮的实现。

Of course, most “ENTITIES” in a software system are not people or entities in the usual sense of the word. An ENTITY is anything that has continuity through a life cycle and distinctions independent of attributes that are important to the application’s user. It could be a person, a city, a car, a lottery ticket, or a bank transaction.

> 当然，软件系统中的大多数“ENTITY”并不是人，也不是其通常意义上所指的“实体”或“存在”。ENTITY可以是任何事物，只要满足两个条件即可，一是它在整个生命周期中具有连续性，二是它的区别并不是由那些对用户非常重要的属性决定的。ENTITY可以是一个人、一座城市、一辆汽车、一张彩票或一次银行交易。

On the other hand, not all objects in the model are ENTITIES, with meaningful identities. This issue is confused by the fact that object-oriented languages build “identity” operations into every object (for example, the “==” operator in Java). These operations determine if two references point to the same object by comparing their location in memory or by some other mechanism. In this sense, every object instance has identity. In the domain of, say, creating a Java runtime environment or a technical framework for caching remote objects locally, every object instance may indeed be an ENTITY. But this identity mechanism means very little in other application domains. Identity is a subtle and meaningful attribute of ENTITIES, which can’t be turned over to the automatic features of the language.

> 另一方面，在一个模型中，并不是所有对象都是具有有意义标识的ENTITY。但是，由于面向对象语言在每个对象中都构建了一些与“标识”有关的操作（如Java中的“==”操作符），这个问题变得有点让人困惑。这些操作通过比较两个引用在内存中的位臵（或通过其他机制）来确定这两个引用是否指向同一个对象。从这个角度讲，每个对象实例都有标识。比方说，当创建一个用于将远程对象缓存到本地的Java运行时环境或技术框架时，这个领域中的每个对象可能确实都是一个ENTITY。但这种标识机制在其他应用领域中却没什么意义。标识是ENTITY的一个微妙的、有意义的属性，我们是不能把它交给语言的自动特性来处理的。

Consider transactions in a banking application. Two deposits of the same amount to the same account on the same day are still distinct transactions, so they have identity and are ENTITIES. On the other hand, the amount attributes of those two transactions are probably instances of some money object. These values have no identity, since there is no usefulness in distinguishing them. In fact, two objects can have the same identity without having the same attributes or even, necessarily, being of the same class. When the bank customer is reconciling the transactions of the bank statement with the transactions of the check registry, the task is, specifically, to match transactions that have the same identity, even though they were recorded by different people on different dates (the bank clearing date being later than the date on the check). The purpose of the check number is to serve as a unique identifier for this purpose, whether the problem is being handled by a computer program or by hand. Deposits and cash withdrawals, which don’t have an identifying number, can be trickier, but the same principle applies: each transaction is an ENTITY, which appears in at least two forms.

> 让我们考虑一下银行应用程序中的交易。同一天、同一个账户的两笔数额相同的存款实际上是两次不同的交易，因此它们是具有各自标识的ENTITY。另一方面，这两笔交易的金额属性可能是某个货币对象的实例。这些值没有标识，因为没有必要区分它们。事实上，两个对象可能有相同的标识，但属性可能不同，在需要的情况下甚至可能不属于同一个类。当银行客户拿银行结算单与支票记录簿进行交易对账时，这项任务就是匹配具有相同标识的交易，尽管它们是由不同的人在不同的日期记录的（银行清算日期比支票上的日期晚）。支票号码就是用于对账的唯一标识符，无论这个问题是由计算机程序处理还是手工处理。存款和取款没有标识号码，因此可能更复杂，但同样的原则也是适用的——每笔交易都是一个ENTITY，至少出现在两张业务表格中。

It is common for identity to be significant outside a particular software system, as is the case with the banking transactions and the apartment tenants. But sometimes the identity is important only in the context of the system, such as the identity of a computer process.

> 标识的重要性并不仅仅体现在特定的软件系统中，在软件系统之外它通常也是非常重要的，银行交易和公寓租客的例子中就是如此。但有时标识只有在系统上下文中才重要，如一个计算机进程的标识。

Therefore:

When an object is distinguished by its identity, rather than its attributes, make this primary to its definition in the model. Keep the class definition simple and focused on life cycle continuity and identity. Define a means of distinguishing each object regardless of its form or history. Be alert to requirements that call for matching objects by attributes. Define an operation that is guaranteed to produce a unique result for each object, possibly by attaching a symbol that is guaranteed unique. This means of identification may come from the outside, or it may be an arbitrary identifier created by and for the system, but it must correspond to the identity distinctions in the model. The model must define what it means to be the same thing.

> 当一个对象由其标识（而不是属性）区分时，那么在模型中应该主要通过标识来确定该对象的定义。使类定义变得简单，并集中关注生命周期的连续性和标识。定义一种区分每个对象的方式，这种方式应该与其形式和历史无关。要格外注意那些需要通过属性来匹配对象的需求。在定义标识操作时，要确保这种操作为每个对象生成唯一的结果，这可以通过附加一个保证唯一性的符号来实现。这种定义标识的方法可能来自外部，也可能是由系统创建的任意标识符，但它在模型中必须是唯一的标识。模型必须定义出“符合什么条件才算是相同的事物”。

Identity is not intrinsic to a thing in the world; it is a meaning superimposed because it is useful. In fact, the same real-world thing might or might not be represented as an ENTITY in a domain model.

> 在现实世界中，并不是每一个事物都必须有一个标识，标识重不重要，完全取决于它是否有用。实际上，现实世界中的同一个事物在领域模型中可能需要表示为ENTITY，也可能不需要表示为ENTITY。

An application for booking seats in a stadium might treat seats and attendees as ENTITIES. In the case of assigned seating, in which each ticket has a seat number on it, the seat is an ENTITY. Its identifier is the seat number, which is unique within the stadium. The seat may have many other attributes, such as its location, whether the view is obstructed, and the price, but only the seat number, or a unique row and position, is used to identify and distinguish seats.

> 体育场座位预订程序可能会将座位和观众当作ENTITY来处理。在分配座位时，每张票都有一个座位号，座位是ENTITY。其标识符就是座位号，它在体育场中是唯一的。座位可能还有很多其他属性，如位臵、视野是否开阔、价格等，但只有座位号（或者说某一排的一个位臵）才用于识别和区分座位。

On the other hand, if the event is “general admission,” meaning that ticket holders sit wherever they find an empty seat, there is no need to distinguish individual seats. Only the total number of seats is important. Although the seat numbers are still engraved on the physical seats, there is no need for the software to track them. In fact, it would be erroneous for the model to associate specific seat numbers with tickets, because there is no such constraint at a general admission event. In such a case, seats are not ENTITIES, and no identifier is needed.

> 另一方面，如果活动采用入场卷的方式，那么观众可以寻找任意的空座位来坐，这样就不需要对座位加以区分。在这种情况下，只有座位总数才是重要的。尽管座位上仍然印有座位号，但软件已经不需要跟踪它们。事实上，这时如果模型仍然将座位号与门票关联起来，那么它就是错误的，因为采用入场卷的活动并没有这样的约束。在这种情况下，座位不是ENTITY，因此不需要标识符。

---

### 5.2.1 Modeling ENTITIES ENTITY建模
It is natural to think about the attributes when modeling an object, and it is quite important to think about its behavior. But the most basic responsibility of ENTITIES is to establish continuity so that behavior can be clear and predictable. They do this best if they are kept spare. Rather than focusing on the attributes or even the behavior, strip the ENTITY object’s definition down to the most intrinsic characteristics, particularly those that identify it or are commonly used to find or match it. Add only behavior that is essential to the concept and attributes that are required by that behavior. Beyond that, look to remove behavior and attributes into other objects associated with the core ENTITY. Some of these will be other ENTITIES. Some will be VALUE OBJECTS, which is the next pattern in this chapter. Beyond identity issues, ENTITIES tend to fulfill their responsibilities by coordinating the operations of objects they own.

> 当对一个对象进行建模时，我们自然而然会考虑它的属性，而且考虑它的行为也显得非常重要。但ENTITY最基本的职责是确保连续性，以便使其行为更清楚且可预测。保持实体的简练是实现这一责任的关键。不要将注意力集中在属性或行为上，应该摆脱这些细枝末节，抓住ENTITY对象定义的最基本特征，尤其是那些用于识别、查找或匹配对象的特征。只添加那些对概念至关重要的行为和这些行为所必需的属性。此外，应该将行为和属性转移到与核心实体关联的其他对象中。这些对象中，有些可能是ENTITY，有些可能是VALUE OBJECT（这是本章接下来要讨论的模式）。除了标识问题之外，实体往往通过协调其关联对象的操作来完成自己的职责。

The customerID is the one and only identifier of the Customer ENTITY in Figure 5.5, but the phone number and address would often be used to find or match a Customer. The name does not define a person’s identity, but it is often used as part of the means of determining it. In this example, the phone and address attributes moved into Customer, but on a real project, that choice would depend on how the domain’s customers are typically matched or distinguished. For example, if a Customer has many contact phone numbers for different purposes, then the phone number is not associated with identity and should stay with the Sales Contact.

> 在图5-5中，customerID是Customer ENTITY的一个（也是唯一的）标识符，但phonenumber（电话号码）和address（地址）都经常用来查找或匹配一个Customer（客户）。name（姓名）没有定义一个人的标识，但它通常是确定人的方式之一。在这个示例中，phone和address属性被移到Customer中，但在实际的项目上，这种选择取决于领域中的Customer一般是如何匹配或区分的。例如，如果一个Customer有很多用于不同目的的phone number，那么phone number就与标识无关，因此应该放在Sales Contact（销售联系人）中。

<Figures figure="5-5">Attributes associated with identity stay with the ENTITY.</Figures>

### 5.2.2 Designing the Identity Operation 设计标识操作
Each ENTITY must have an operational way of establishing its identity with another object—distinguishable even from another object with the same descriptive attributes. An identifying attribute must be guaranteed to be unique within the system however that system is defined—even if distributed, even when objects are archived.

> 每个ENTITY都必须有一种建立标识的操作方式，以便与其他对象区分开，即使这些对象与它具有相同的描述属性。不管系统是如何定义的，都必须确保标识属性在系统中是唯一的，即使是在分布式系统中，或者对象已被归档，也必须确保标识的唯一性。

As mentioned earlier, object-oriented languages have “identity” operations that determine if two references point to the same object by comparing the objects’ locations in memory. This kind of identity tracking is too fragile for our purposes. In most technologies for persistent storage of objects, every time an object is retrieved from a database, a new instance is created, and so the initial identity is lost. Every time an object is transmitted across a network, a new instance is created on the destination, and once again the identity is lost. The problem can be even worse when multiple versions of the same object exist in the system, such as when updates propagate through a distributed database.

> 如前所述，面向对象语言有一些“标识”操作，它们通过比较对象在内存中的位臵来确定两个引用是否指向同一个对象。这种标识跟踪机制过于简单，无法满足我们的目的。在大多数对象持久存储技术中，每次从数据库检索出一个对象时，都会创建一个新实例，这样原来的标识就丢失了。每次在网络上传输对象时，在目的地也会创建一个新实例，这也会导致标识的丢失。当系统中存在同一对象的多个版本时（例如，通过分布式数据库来传播更新的时候），问题将会更复杂。

Even with frameworks that simplify these technical problems, the fundamental issue exists: How do you know that two objects represent the same conceptual ENTITY? The definition of identity emerges from the model. Defining identity demands understanding of the domain.

> 尽管有一些用于简化这些技术问题的框架，但基本问题仍然存在。如何才能判定两个对象是否表示同一个概念ENTITY？标识是在模型中定义的。定义标识要求理解领域。

Sometimes certain data attributes, or combinations of attributes, can be guaranteed or simply constrained to be unique within the system. This approach provides a unique key for the ENTITY. Daily newspapers, for example, might be identified by the name of the newspaper, the city, and the date of publication. (But watch out for extra editions and name changes!)

> 有时，某些数据属性或属性组合可以确保它们在系统中具有唯一性，或者在这些属性上加一些简单约束可以使其具有唯一性。这种方法为ENTITY提供了唯一键。例如，日报可以通过名称、城市和出版日期来识别。（但要注意临时增刊和名称变更！）

When there is no true unique key made up of the attributes of an object, another common solution is to attach to each instance a symbol (such as a number or a string) that is unique within the class. Once this ID symbol is created and stored as an attribute of the ENTITY, it is designated immutable. It must never change, even if the development system is unable to directly enforce this rule. For example, the ID attribute is preserved as the object gets flattened into a database and reconstructed. Sometimes a technical framework helps with this process, but otherwise it just takes engineering discipline.

> 当对象属性没办法形成真正唯一键时，另一种经常用到的解决方案是为每个实例附加一个在类中唯一的符号（如一个数字或字符串）。一旦这个ID符号被创建并存储为ENTITY的一个属性，必须将它指定为不可变的。它必须永远不变，即使开发系统无法直接强制这条规则。例如，当对象被扁平化到数据库中或从数据库中重新创建时，ID属性应该保持不变。有时可以利用技术框架来实现此目的，但如果没有这样的框架，就需要通过工程纪律来约束。

Often the ID is generated automatically by the system. The generation algorithm must guarantee uniqueness within the system, which can be a challenge with concurrent processing and in distributed systems. Generating such an ID may require techniques that are beyond the scope of this book. The goal here is to point out when the considerations arise, so that developers are aware they have a problem to solve and know how to narrow down their concerns to the critical areas. The key is to recognize that identity concerns hinge on specific aspects of the model. Often, the means of identification demand a careful study of the domain, as well.

> ID通常是由系统自动生成的。生成算法必须确保ID在系统中是唯一的。在并行处理系统和分布式系统中，这可能是一个难题。生成这种ID的技术超出了本书的范围。这里的目的是指出何时需要考虑这些问题，以便使开发人员能够意识到有一个问题等待他们去解决，并知道如何将注意力集中到关键问题上。关键是要认识到标识问题取决于模型的特定方面。通常，要想找到解决标识问题的方法，必须对领域进行仔细的研究。

When the ID is automatically generated, the user may never need to see it. The ID may be needed only internally, such as in a contact management application that lets the user find records by a person’s name. The program needs to be able to distinguish two contacts with exactly the same name in a simple, unambiguous way. The unique, internal IDs let the system do just that. After retrieving the two distinct items, the system will show two separate contacts to the user, but the IDs may not be shown. The user will distinguish them on the basis of their company, their location, and so on.

> 当自动生成ID时，用户可能永远不需要看到它。ID可能只是在内部需要，例如，在一个可以按人名查找记录的联系人管理应用程序中。这个程序需要用一种简单、明确的方式来区分两个同名联系人，这就可以通过唯一的内部ID来实现。在检索出两个不同的条目后，系统将显示这两个不同的联系人，但可能不会显示ID。用户可以通过这两个人的公司、地点等属性来区分他们。

Finally, there are cases in which a generated ID is of interest to the user. When I ship a package through a parcel delivery service, I’m given a tracking number, generated by the shipping company’s software, which I can use to identify and follow up on my package. When I book airline tickets or reserve a hotel, I’m given confirmation numbers that are unique identifiers for the transaction.

> 最后，在有些情况下用户会对生成的ID感兴趣。当我委托一个包裹运送服务寄包裹时，我会得到一个跟踪号，它是由运送公司的软件生成的，我可以用这个号码来识别和跟踪我的包裹。当我预订机票或酒店时，会得到一个确认号码，它是预订交易的唯一标识符。

In some cases, the uniqueness of the ID must apply beyond the computer system’s boundaries. For example, if medical records are being exchanged between two hospitals that have separate computer systems, ideally each system will use the same patient ID, but this is difficult if they generate their own symbol. Such systems often use an identifier issued by some other institution, typically a government agency. In the United States, the Social Security number is often used by hospitals as an identifier for a person. Such methods are not foolproof. Not everyone has a Social Security number (children and nonresidents of the United States, especially), and many people object to its use, for privacy reasons.

> 在某些情况下，需要确保ID在多个计算机系统之间具有唯一性。例如，如果需要在两家具有不同计算机系统的医院之间交换医疗记录，那么理想情况下每个系统对同一个病人应该使用同一个ID，但如果这两个系统各自生成自己的ID，这就很难实现。这样的系统通常使用由另外一家机构（一般是政府机构）发放的标识符。在美国，医院通常使用社会保险号码作为病人的标识符。但这样的方法也不是万无一失的，因为并不是每个人都有社会保险号码（特别是儿童和非美国居民），而且很多人会出于个人隐私原因而反对这种做法。

In less formal situations (say, video rental), telephone numbers are used as identifiers. But a telephone can be shared. The number can change. An old number can even be reassigned to a different person.

> 在一些非正式的场合（比方说，音像出租），可以使用电话号码作为标识符。但电话可能是共用的，号码也可能会更改，甚至一个旧的电话号码可能会重新分配给一个不同的人。

For these reasons, specially assigned identifiers are often used (such as frequent flier numbers), and other attributes, such as phone numbers and Social Security numbers, are used to match and verify. In any case, when the application requires an external ID, the users of the system become responsible for supplying IDs that are unique, and the system must give them adequate tools to handle exceptions that arise.

> 由于这些原因，我们一般使用特别指定的标识符（如常飞乘客[插图]编号），并使用其他属性（如电话号码和社会保险号码[插图]）进行匹配和验证。在任何情况下，当应用程序需要一个外部ID时，都由系统的用户负责提供唯一的ID，而系统必须为用户提供适当的工具来处理异常情况。

Given all these technical problems, it is easy to lose sight of the underlying conceptual problem: What does it mean for two objects to be the same thing? It is easy enough to stamp each object with an ID, or to write an operation that compares two instances, but if these IDs or operations don’t correspond to some meaningful distinction in the domain, they just confuse matters more. This is why identity-assigning operations often involve human input. Checkbook reconciliation software, for instance, may offer likely matches, but the user is expected to make the final determination.

> 在这些技术问题的干扰下，人们很容易忽略基本的概念问题：两个对象是同一事物时意味着什么？我们很容易为每个对象分配一个ID，或是编写一个用于比较两个实例的操作，但如果这些ID或操作没有对应领域中有意义的区别，那只会使问题更混乱。这就是分配标识的操作通常需要人工输入的原因。例如，支票簿对账软件可以提供一些有可能匹配的账目，但它们是否真的匹配则要由用户最终决定。

## 5.3 VALUE OBJECTS 模式：VALUE OBJECT
Image
Many objects have no conceptual identity. These objects describe some characteristic of a thing.

> 很多对象没有概念上的标识，它们描述了一个事务的某种特征。

---

When a child is drawing, he cares about the color of the marker he chooses, and he may care about the sharpness of the tip. But if there are two markers of the same color and shape, he probably won’t care which one he uses. If a marker is lost and replaced by another of the same color from a new pack, he can resume his work unconcerned about the switch.

> 当一个小孩画画的时候，他注意的是画笔的颜色和笔尖的粗细。但如果有两只颜色和粗细相同的画笔，他可能不会在意使用哪一支。如果有一支笔弄丢了，他可以从一套新笔中拿出一支同样颜色的笔来继续画，根本不会在意已经换了一支笔。

Ask the child about the various drawings on the refrigerator, and he will quickly distinguish those he made from those his sister made. He and his sister have useful identities, as do their completed drawings. But imagine how complicated it would be if he had to track which lines in a drawing were made by each marker. Drawing would no longer be child’s play.

> 问问孩子冰箱上的画都是谁画的，他会很快辨认出哪些是他画的，哪些是他姐姐画的。姐弟俩有一些实用的标识来区分自己，与此类似，他们完成的作品也有。但设想一下，如果孩子必须记住哪些线条是用哪支笔画的，情况该有多么复杂？如果这样的话，画画将不再是小孩子的游戏了。

Because the most conspicuous objects in a model are usually ENTITIES, and because it is so important to track each ENTITY’s identity, it is natural to consider assigning an identity to all domain objects. Indeed, some frameworks assign a unique ID to every object.

> 由于模型中最引人注意的对象往往是ENTITY，而且跟踪每个ENTITY的标识是极为重要的，因此我们很自然地会想到为每个领域对象都分配一个标识。实际上，一些框架确实为每个对象分配了一个唯一的ID。

The system has to cope with all that tracking, and many possible performance optimizations are ruled out. Analytical effort is required to define meaningful identities and work out foolproof ways to track objects across distributed systems or in database storage. Equally important, taking on artificial identities is misleading. It muddles the model, forcing all objects into the same mold.

> 这样一来，系统就必须处理所有这些ID的跟踪问题，从而导致许多本来可能的性能优化不得不被放弃。此外，人们还需要付出大量的分析工作来定义有意义的标识，还需要开发出一些可靠的跟踪方式，以便在分布式系统或在数据库存储中跟踪对象。同样重要的是，盲目添加无实际意义的标识可能会产生误导。它会使模型变得混乱，并使所有对象看起来千篇一律。

Tracking the identity of ENTITIES is essential, but attaching identity to other objects can hurt system performance, add analytical work, and muddle the model by making all objects look the same.

> 跟踪ENTITY的标识是非常重要的，但为其他对象也加上标识会影响系统性能并增加分析工作，而且会使模型变得混乱，因为所有对象看起来都是相同的。

Software design is a constant battle with complexity. We must make distinctions so that special handling is applied only where necessary.

> 软件设计要时刻与复杂性做斗争。我们必须区别对待问题，仅在真正需要的地方进行特殊处理。

However, if we think of this category of object as just the absence of identity, we haven’t added much to our toolbox or vocabulary. In fact, these objects have characteristics of their own and their own significance to the model. These are the objects that describe things.

> 然而，如果仅仅把这类对象当作没有标识的对象，那么就忽略了它们的工具价值或术语价值。事实上，这些对象有其自己的特征，对模型也有着自己的重要意义。这些是用来描述事物的对象。

An object that represents a descriptive aspect of the domain with no conceptual identity is called a VALUE OBJECT. VALUE OBJECTS are instantiated to represent elements of the design that we care about only for what they are, not who or which they are.

> 用于描述领域的某个方面而本身没有概念标识的对象称为VALUE OBJECT（值对象）。VALUEOBJECT被实例化之后用来表示一些设计元素，对于这些设计元素，我们只关心它们是什么，而不关心它们是谁。

Is “Address” a VALUE OBJECT? Who’s Asking?

> “地址”是VALUE OBJECT吗？谁会问这个问题？

In software for a mail-order company, an address is needed to confirm the credit card, and to address the parcel. But if a roommate also orders from the same company, it is not important to realize they are in the same location. Address is a VALUE OBJECT.

> 在一个邮购公司的软件中，需要用地址来核实信用卡并投递包裹。但如果一个人的室友也从同一家公司订购了货物，那么是否意识到他们住在同一个地方并不重要。因此地址是一个VALUE OBJECT。

In software for the postal service, intended to organize delivery routes, the country could be formed into a hierarchy of regions, cities, postal zones, and blocks, terminating in individual addresses. These address objects would derive their zip code from their parent in the hierarchy, and if the postal service decided to reassign postal zones, all the addresses within would go along for the ride. Here, Address is an ENTITY.

> 在一个用于安排投递路线的邮政服务软件中，国家可能被组织为一个由地区、城市、邮政区、街区以及最终的个人地址组成的层次结构。这些地址对象可以从它们在层次结构中的父对象获取邮政编码，而且，如果邮政服务决定重新划分邮政区，那么所有地址都将随之改变。在这里，地址是一个ENTITY。

In software for an electric utility company, an address corresponds to a destination for the company’s lines and service. If roommates each called to order electrical service, the company would need to realize it. Address is an ENTITY. Alternatively, the model could associate utility service with a “dwelling,” an ENTITY with an attribute of address. Then Address would be a VALUE OBJECT.

> 在电力运营公司的软件中，一个地址对应于公司线路和服务的一个目的地。如果几个室友各自打电话申请电力服务，公司需要知道他们其实是住在同一个地方。在这种情况下，地址是一个ENTITY。换种方式，模型可以将电力服务与“住处”关联起来，那么住处就是一个带有地址属性的ENTITY了，这时，地址就是一个VALUE OBJECT。

Colors are an example of VALUE OBJECTS that are provided in the base libraries of many modern development systems; so are strings and numbers. (You don’t care which “4” you have or which “Q”.) These basic examples are simple, but VALUE OBJECTS are not necessarily simple. For example, a color-mixing program might have a rich model in which enhanced color objects could be combined to produce other colors. These colors could have complex algorithms for collaborating to derive the new resulting VALUE OBJECT.

> 颜色是很多现代开发系统的基础库所提供的VALUE OBJECT的一个例子，字符串和数字也是这样的VALUE OBJECT（我们不会关心所使用的是哪一个“4”或哪一个“Q”）。这些基本的例子非常简单，但VALUE OBJECT并不都这样简单。例如，调色程序可能有一个功能丰富的模型，在这个模型中，可以把功能更强的颜色对象组合起来产生其他颜色。这些颜色可能具有很复杂的算法，通过这些算法的共同计算得到新的VALUE OBJECT。

A VALUE OBJECT can be an assemblage of other objects. In software for designing house plans, an object could be created for each window style. This “window style” could be incorporated into a “window” object, along with height and width, as well as rules governing how these attributes can be changed and combined. These windows are intricate VALUE OBJECTS made up of other VALUE OBJECTS. They in turn would be incorporated into larger elements of a plan, such as “wall” objects.

> VALUE OBJECT可以是其他对象的集合。在房屋设计软件中，可以为每种窗户样式创建一个对象。我们可以将“窗户样式”连同它的高度、宽度以及修改和组合这些属性的规则一起放到“窗户”对象中。这些窗户就是由其他VALUE OBJECT组成的复杂VALUE OBJECT。它们进而又被合并到更大的设计元素中，如“墙”对象。

VALUE OBJECTS can even reference ENTITIES. For example, if I ask an online map service for a scenic driving route from San Francisco to Los Angeles, it might derive a Route object linking L.A. and San Francisco via the Pacific Coast Highway. That Route object would be a VALUE, even though the three objects it references (two cities and a highway) are all ENTITIES.

> VALUE OBJECT甚至可以引用ENTITY。例如，如果我请在线地图服务为我提供一个从旧金山到洛杉矶的驾车风景游路线，它可能会得出一个“路线”对象，此对象通过太平洋海岸公路连接旧金山和洛杉矶。这个“路线”对象是一个VALUE，尽管它所引用的3个对象（两座城市和一条公路）都是ENTITY。

VALUE OBJECTS are often passed as parameters in messages between objects. They are frequently transient, created for an operation and then discarded. VALUE OBJECTS are used as attributes of ENTITIES (and other VALUES). A person may be modeled as an ENTITY with an identity, but that person’s name is a VALUE.

> VALUE OBJECT经常作为参数在对象之间传递消息。它们常常是临时对象，在一次操作中被创建，然后丢弃。VALUE OBJECT可以用作ENTITY（以及其他VALUE）的属性。我们可以把一个人建模为一个具有标识的ENTITY，但这个人的名字是一个VALUE。

When you care only about the attributes of an element of the model, classify it as a VALUE OBJECT. Make it express the meaning of the attributes it conveys and give it related functionality. Treat the VALUE OBJECT as immutable. Don’t give it any identity and avoid the design complexities necessary to maintain ENTITIES.

> 当我们只关心一个模型元素的属性时，应把它归类为VALUE OBJECT。我们应该使这个模型元素能够表示出其属性的意义，并为它提供相关功能。VALUE OBJECT应该是不可变的。不要为它分配任何标识，而且不要把它设计成像ENTITY那么复杂。

The attributes that make up a VALUE OBJECT should form a conceptual whole.2 For example, street, city, and postal code shouldn’t be separate attributes of a Person object. They are part of a single, whole address, which makes a simpler Person, and a more coherent VALUE OBJECT.

> VALUE OBJECT所包含的属性应该形成一个概念整体[插图]。例如，street（街道）、city（城市）和postal code（邮政编码）不应是Person（人）对象的单独的属性。它们是整个地址的一部分，这样可以使得Person对象更简单，并使地址成为一个更一致的VALUE OBJECT，如图5-6所示。

<Figures figure="5-6">A VALUE OBJECT can give information about an ENTITY. It should be conceptually whole.</Figures>

---

### 5.3.1 Designing VALUE OBJECTS 设计VALUE OBJECT
We don’t care which instance we have of a VALUE OBJECT. This lack of constraints gives us design freedom we can use to simplify the design or optimize performance. This involves making choices about copying, sharing, and immutability.

> 我们并不关心使用的是VALUE OBJECT的哪个实例。由于不受这方面的约束，设计可以获得更大的自由，因此可以简化设计或优化性能。在设计VALUE OBJECT时有多种选择，包括复制、共享或保持VALUE OBJECT不变。

If two people have the same name, that does not make them the same person, or make them interchangeable. But the object representing the name is interchangeable, because only the spelling of the name matters. A Name object can be copied from the first Person object to the second.

> 两个人同名并不意味着他们是同一个人，也不意味着他们是可互换的。但表示名字的对象是可以互换的，因为它们只涉及名字的拼写。一个Name对象可以从第一个Person对象复制给第二个Person对象。

In fact, the two Person objects might not need their own name instances. The same Name object could be shared between the two Person objects (each with a pointer to the same name instance) with no change in their behavior or identity. That is, their behavior will be correct until some change is made to the name of one person. Then the other person’s name would change also! To protect against this, in order for an object to be shared safely, it must be immutable: it cannot be changed except by full replacement.

> 事实上，这两个Person对象可能不需要自己的名字实例，它们可以共享同一个Name对象（其中每个Person对象都有一个指向同一个名字实例的指针），而无需改变它们的行为或标识。如此一来，当修改其中一个人名字时就会产生问题，这时另一个人的名字也将改变！为了防止这种错误发生，以便安全地共享一个对象，必须确保Name对象是不变的——它不能改变，除非将其整个替换掉。


The same issues arise when an object passes one of its attributes to another object as an argument or return value. Anything could happen to the wandering object while it is out of control of its owner. The VALUE could be changed in a way that corrupts the owner, by violating the owner’s invariants. This problem is avoided either by making the passed object immutable, or by passing a copy.

> 当一个对象将它的一个属性作为参数或返回值传递给另一个对象时，也会发生同样的问题。一个脱离了其所有者控制的“流浪”对象可能会发生任何事情。VALUE的改变可能会破坏所有者的约束条件。这个问题可以通过传递一个不变对象或传递一个副本来解决。

Creating extra options for performance tuning can be important because VALUE OBJECTS tend to be numerous. The example of the house design software hints at this. If each electrical outlet is a separate VALUE OBJECT, there might be a hundred of them in a single version of a single house plan. But if all outlets are considered interchangeable, we could share just one instance of an outlet and point to it a hundred times (an example of FLYWEIGHT [Gamma et al. 1995]). In large systems, this kind of effect can be multiplied by thousands, and such an optimization can make the difference between a usable system and one that slows to a crawl, choked on millions of redundant objects. This is just one example of an optimization trick that is not available for ENTITIES.

> VALUE OBJECT为性能优化提供了更多选择，这一点可能很重要，因为VALUE OBJECT往往为数众多。房屋设计软件的示例就说明了这一点。如果每个电源插座都是一个单独的VALUEOBJECT，那么在一所房屋的一个设计版本中可能就会有上百个这种VALUE OBJECT。但如果把电源插座看成是可互换的，就只需共享一个电源插座实例，并让所有电源插座都指向这个实例（FLYWEIGHT, [Gamma et al. 1995]中的一个示例）。在大型系统中，这种效果可能会被放大数千倍，而且这样的优化可能决定一个系统是可用的，还是由于数百万个多余对象而变得异常缓慢。这只是无法应用于ENTITY的优化技巧中的一个。

The economy of copying versus sharing depends on the implementation environment. Although copies may clog the system with huge numbers of objects, sharing can slow down a distributed system. When a copy is passed between two machines, a single message is sent and the copy lives independently on the receiving machine. But if a single instance is being shared, only a reference is passed, requiring a message back to the object for each interaction.

> 复制和共享哪个更划算取决于实现环境。虽然复制有可能导致系统被大量的对象阻塞，但共享可能会减慢分布式系统的速度。当在两个机器之间传递一个副本时，只需发送一条消息，而且副本到达接收端后是独立存在的。但如果共享一个实例，那么只会传递一个引用，这要求每次交互都要向发送方返回一条消息。


Sharing is best restricted to those cases in which it is most valuable and least troublesome:

> 以下几种情况最好使用共享，这样可以发挥共享的最大价值并最大限度地减少麻烦：

- When saving space or object count in the database is critical
- When communication overhead is low (such as in a centralized server)
- When the shared object is strictly immutable

---


> - 节省数据库空间或减少对象数量是一个关键要求时；
> - 通信开销很低时（如在中央服务器中）；
> - 共享的对象被严格限定为不可变时。

Immutability of an attribute or an object can be declared in some languages and environments but not in others. Such features help communicate the design decision, but they are not essential. Many of the distinctions we are making in the model cannot be explicitly declared in the implementation with most current tools and programming languages. You can’t declare ENTITIES, for example, and then have an identity operation automatically enforced. But the lack of direct language support for a conceptual distinction does not mean that the distinction is not useful. It just means that more discipline is needed to maintain the rules that will be only implicit in the implementation. This can be reinforced with naming conventions, selective documentation, and lots of discussion.

> 在有些语言和环境中，可以将属性或对象声明为不可变的，但有些却不具备这种能力。这种声明能够体现出设计决策，但它们并不是十分重要。我们在模型中所做的很多区别都无法用当前工具和编程语言在实现中显式地声明出来。例如，我们无法声明ENTITY并自动确保其具有一个标识操作。但是，编程语言没有直接支持这些概念上的区别并不说明这些区别没有用处。这只是说明我们需要更多的约束机制来确保满足一些重要的规则（这些规则只有在实现中才是隐式的）。命名规则、精心准备的文档和大量讨论都可以强化这些需求。

As long as a VALUE OBJECT is immutable, change management is simple—there isn’t any change except full replacement. Immutable objects can be freely shared, as in the electrical outlet example. If garbage collection is reliable, deletion is just a matter of dropping all references to the object. When a VALUE OBJECT is designated immutable in the design, developers are free to make decisions about issues such as copying and sharing on a purely technical basis, secure in the knowledge that the application does not rely on particular instances of the objects.

> 只要VALUE OBJECT是不可变的，变更管理就会很简单，因为除了整体替换之外没有其他的更改。不变的对象可以自由地共享，像在电源插座的例子中一样。如果垃圾回收是可靠的，那么删除操作就只是将所有指向对象的引用删除。当在设计中将一个VALUE OBJECT指定为不可变时，开发人员就可以完全根据技术需求来决定是使用复制，还是使用共享，因为他们没有后顾之忧——应用程序不依赖于对象的特殊实例。

Special Cases: When to Allow Mutability

> 特殊情况：何时允许可变性

Immutability is a great simplifier in an implementation, making sharing and reference passing safe. It is also consistent with the meaning of a value. If the value of an attribute changes, you use a different VALUE OBJECT, rather than modifying the existing one. Even so, there are cases when performance considerations will favor allowing a VALUE OBJECT to be mutable. These factors would weigh in favor of a mutable implementation:


> 保持VALUE OBJECT不变可以极大地简化实现，并确保共享和引用传递的安全性。而且这样做也符合值的意义。如果属性的值发生改变，我们应该使用一个不同的VALUEOBJECT，而不是修改现有的VALUE OBJECT。尽管如此，在有些情况下出于性能考虑，仍需要让VALUE OBJECT是可变的。这包括以下因素：

- If the VALUE changes frequently
- If object creation or deletion is expensive
- If replacement (rather than modification) will disturb clustering (as discussed in the previous example)
- If there is not much sharing of VALUES, or if such sharing is forgone to improve clustering or for some other technical reason

---


> - 如果VALUE频繁改变；
> - 如果创建或删除对象的开销很大；
> - 如果替换（而不是修改）将打乱集群（像前面示例中讨论的那样）；
> - 如果VALUE的共享不多，或者共享不会提高集群性能，或其他某种技术原因。

Just to reiterate: If a VALUE’s implementation is to be mutable, then it must not be shared. Whether you will be sharing or not, design VALUE OBJECTS as immutable when you can.

> 再次强调：如果一个VALUE的实现是可变的，那么就不能共享它。无论是否共享VALUEOBJECT，在可能的情况下都要将它们设计为不可变的。

Defining VALUE OBJECTS and designating them as immutable is a case of following a general rule: Avoiding unnecessary constraints in a model leaves developers free to do purely technical performance tuning. Explicitly defining the essential constraints lets developers tweak the design while keeping safe from changing meaningful behavior. Such design tweaks are often very specific to the technology in use on a particular project.

> 定义VALUE OBJECT并将其指定为不可变的是一条一般规则，这样做是为了避免在模型中产生不必要的约束，从而让开发人员可以单纯地从技术上优化性能。如果开发人员能够显式地定义重要约束，那么他们就可以在对设计做出必要调整时，确保不会无意更改重要的行为。这样的设计调整往往特定于具体项目所使用的技术。

Example: Tuning a Database with VALUE OBJECTS

> 示例通过VALUE OBJECT来优化数据库

Databases, at the lowest level, have to place data in a physical location on a disk, and it takes time for physical parts to move around and read that data. Sophisticated databases attempt to cluster these physical addresses so that related data can be fetched from the disk in a single physical operation.

> 数据库——在其最底层——是将数据存储到物理磁盘的一个具体位臵上，或者花时间移动物理部件将数据读取出来。高级数据库则尝试将这些物理地址聚集到一起，以便可以在一次物理操作中从磁盘读取相互关联的数据。

If an object is referenced by many other objects, some of those objects will not be located nearby (on the same page), requiring an additional physical operation to get the data. By making a copy, rather than sharing a reference to the same instance, a VALUE OBJECT that is acting as an attribute of many ENTITIES can be stored on the same page as each ENTITY that uses it. This technique of storing multiple copies of the same data is called denormalization and is often used when access time is more critical than storage space or simplicity of maintenance.

> 如果一个对象被许多对象引用，其中有些对象将不会在它附近（不在同一分页上），这就需要通过额外的物理操作来获取数据。通过复制（而不是共享对同一个实例的引用），可以将这种作为很多ENTITY属性的VALUE OBJECT存储在ENTITY所在的同一分页上。这种存储相同数据的多个副本的技术称为非规范化（denormalization），当访问时间比存储空间或维护的简单性更重要时，通常使用这种技术。

In a relational database, you might want to put a particular VALUE in the table of the ENTITY that owns it, rather than creating an association to a separate table. In a distributed system, holding a reference to a VALUE OBJECT on another server will probably make for slow responses to messages; instead, a copy of the whole object should be passed to the other server. We can freely make these copies because we are dealing with VALUE OBJECTS.

> 在关系数据库中，我们可能想把一个具体的值放到拥有此值的ENTITY的表中，而不是将其关联到另一个单独的表。在分布式系统中，对一个位于另一台服务器上的VALUE OBJECT的引用可能导致对消息的响应十分缓慢，在这种情况下，应该将整个对象的副本传递到另一台服务器上。我们可以随意地使用副本，因为处理的是VALUE OBJECT。

### 5.3.2 Designing Associations That Involve VALUE OBJECTS 设计包含VALUE OBJECT的关联
Most of the earlier discussion of associations applies to ENTITIES and VALUE OBJECTS alike. The fewer and simpler the associations in the model, the better.

> 前面讨论的与关联有关的大部分内容也适用于ENTITY和VALUE OBJECT。模型中的关联越少越好，越简单越好。

But, while bidirectional associations between ENTITIES may be hard to maintain, bidirectional associations between two VALUE OBJECTS just make no sense. Without identity, it is meaningless to say that an object points back to the same VALUE OBJECT that points to it. The most you could say is that it points to an object that is equal to the one pointing to it, but you would have to enforce that invariant somewhere. And although you could do so, and set up pointers going both ways, it is hard to think of examples where such an arrangement would be useful. Try to completely eliminate bidirectional associations between VALUE OBJECTS. If in the end such associations seem necessary in your model, rethink the decision to declare the object a VALUE OBJECT in the first place. Maybe it has an identity that hasn’t been explicitly recognized yet.

> 但是，如果说ENTITY之间的双向关联很难维护，那么两个VALUE OBJECT之间的双向关联则完全没有意义。当一个VALUE OBJECT指向另一个VALUE OBJECT时，由于没有标识，说一个对象指向的对象正是那个指向它的对象并没有任何意义的。我们充其量只能说，一个对象指向的对象与那个指向它的对象是等同的，但这可能要求我们必须在某个地方实施这个固定规则。而且，尽管我们可以这样做，并设臵双向指针，但很难想出这种安排有什么用处。因此，我们应尽量完全清除VALUE OBJECT之间的双向关联。如果在你的模型中看起来确实需要这种关联，那么首先应重新考虑一下将对象声明为VALUE OBJECT这个决定是否正确。或许它拥有一个标识，而你还没有注意到它。

ENTITIES and VALUE OBJECTS are the main elements of conventional object models, but pragmatic designers have come to use one other element, SERVICES. . . .

> ENTITY和VALUE OBJECT是传统对象模型的主要元素，但一些注重实效的设计人员正逐渐开始使用一种新的元素——SERVICE。

## 5.4 SERVICES 模式：SERVICE
Image
Sometimes, it just isn’t a thing.

> 有时，对象不是一个事物。

In some cases, the clearest and most pragmatic design includes operations that do not conceptually belong to any object. Rather than force the issue, we can follow the natural contours of the problem space and include SERVICES explicitly in the model.

在某些情况下，最清楚、最实用的设计会包含一些特殊的操作，这些操作从概念上讲不属于任何对象。与其把它们强制地归于哪一类，不如顺其自然地在模型中引入一种新的元素，这就是SERVICE（服务）。

---

There are important domain operations that can’t find a natural home in an ENTITY or VALUE OBJECT. Some of these are intrinsically activities or actions, not things, but since our modeling paradigm is objects, we try to fit them into objects anyway.

有些重要的领域操作无法放到ENTITY或VALUE OBJECT中。这当中有些操作从本质上讲是一些活动或动作，而不是事物，但由于我们的建模范式是对象，因此要想办法将它们划归到对象这个范畴里。

Now, the more common mistake is to give up too easily on fitting the behavior into an appropriate object, gradually slipping toward procedural programming. But when we force an operation into an object that doesn’t fit the object’s definition, the object loses its conceptual clarity and becomes hard to understand or refactor. Complex operations can easily swamp a simple object, obscuring its role. And because these operations often draw together many domain objects, coordinating them and putting them into action, the added responsibility will create dependencies on all those objects, tangling concepts that could be understood independently.

> 现在，一个比较常见的错误是没有努力为这类行为找到一个适当的对象，而是逐渐转为过程化的编程。但是，当我们勉强将一个操作放到不符合对象定义的对象中时，这个对象就会产生概念上的混淆，而且会变得很难理解或重构。复杂的操作很容易把一个简单对象搞乱，使对象的角色变得模糊。此外，由于这些操作常常会牵扯到很多领域对象——需要协调这些对象以便使它们工作，而这会产生对所有这些对象的依赖，将那些本来可以单独理解的概念缠杂在一起。

Sometimes services masquerade as model objects, appearing as objects with no meaning beyond doing some operation. These “doers” end up with names ending in “Manager” and the like. They have no state of their own nor any meaning in the domain beyond the operation they host. Still, at least this solution gives these distinct behaviors a home without messing up a real model object.

> 有时，一些SERVICE看上去就像是模型对象，它们以对象的形式出现，但除了执行一些操作之外并没有其他意义。这些“实干家”（Doer）的名字通常以“Manager”之类的名字结尾。它们没有自己的状态，而且除了所承载的操作之外在领域中也没有其他意义。尽管如此，该方法至少为这些特立独行的行为找到了一个容身之所，避免它们扰乱真正的模型对象。

Some concepts from the domain aren’t natural to model as objects. Forcing the required domain functionality to be the responsibility of an ENTITY or VALUE either distorts the definition of a model-based object or adds meaningless artificial objects.

> 一些领域概念不适合被建模为对象。如果勉强把这些重要的领域功能归为ENTITY或VALUEOBJECT的职责，那么不是歪曲了基于模型的对象的定义，就是人为地增加了一些无意义的对象。

A SERVICE is an operation offered as an interface that stands alone in the model, without encapsulating state, as ENTITIES and VALUE OBJECTS do. SERVICES are a common pattern in technical frameworks, but they can also apply in the domain layer.

> SERVICE是作为接口提供的一种操作，它在模型中是独立的，它不像ENTITY和VALUE OBJECT那样具有封装的状态。SERVICE是技术框架中的一种常见模式，但它们也可以在领域层中使用。

The name service emphasizes the relationship with other objects. Unlike ENTITIES and VALUE OBJECTS, it is defined purely in terms of what it can do for a client. A SERVICE tends to be named for an activity, rather than an entity—a verb rather than a noun. A SERVICE can still have an abstract, intentional definition; it just has a different flavor than the definition of an object. A SERVICE should still have a defined responsibility, and that responsibility and the interface fulfilling it should be defined as part of the domain model. Operation names should come from the UBIQUITOUS LANGUAGE or be introduced into it. Parameters and results should be domain objects.

> 所谓SERVICE，它强调的是与其他对象的关系。与ENTITY和VALUE OBJECT不同，它只是定义了能够为客户做什么。SERVICE往往是以一个活动来命名，而不是以一个ENTITY来命名，也就是说，它是动词而不是名词。SERVICE也可以有抽象而有意义的定义，只是它使用了一种与对象不同的定义风格。SERVICE也应该有定义的职责，而且这种职责以及履行它的接口也应该作为领域模型的一部分来加以定义。操作名称应来自于UBIQUITOUS LANGUAGE，如果UBIQUITOUS LANGUAGE中没有这个名称，则应该将其引入到UBIQUITOUS LANGUAGE中。参数和结果应该是领域对象。

SERVICES should be used judiciously and not allowed to strip the ENTITIES and VALUE OBJECTS of all their behavior. But when an operation is actually an important domain concept, a SERVICE forms a natural part of a MODEL-DRIVEN DESIGN. Declared in the model as a SERVICE, rather than as a phony object that doesn’t actually represent anything, the standalone operation will not mislead anyone.

> 使用SERVICE时应谨慎，它们不应该替代ENTITY和VALUE OBJECT的所有行为。但是，当一个操作实际上是一个重要的领域概念时，SERVICE很自然就会成为MODEL-DRIVEN DESIGN中的一部分。将模型中的独立操作声明为一个SERVICE，而不是声明为一个不代表任何事情的虚拟对象，可以避免对任何人产生误导。

A good SERVICE has three characteristics.

> 好的SERVICE有以下3个特征。

1. The operation relates to a domain concept that is not a natural part of an ENTITY or VALUE OBJECT.
2. The interface is defined in terms of other elements of the domain model.
3. The operation is stateless.

---


> 1. 与领域概念相关的操作不是ENTITY或VALUE OBJECT的一个自然组成部分。
> 2. 接口是根据领域模型的其他元素定义的。
> 3. 操作是无状态的。

Statelessness here means that any client can use any instance of a particular SERVICE without regard to the instance’s individual history. The execution of a SERVICE will use information that is accessible globally, and may even change that global information (that is, it may have side effects). But the SERVICE does not hold state of its own that affects its own behavior, as most domain objects do.

> 这里所说的无状态是指任何客户都可以使用某个SERVICE的任何实例，而不必关心该实例的历史状态。SERVICE执行时将使用可全局访问的信息，甚至会更改这些全局信息（也就是说，它可能具有副作用）。但SERVICE不保持影响其自身行为的状态，这一点与大多数领域对象不同。

When a significant process or transformation in the domain is not a natural responsibility of an ENTITY or VALUE OBJECT, add an operation to the model as a standalone interface declared as a SERVICE. Define the interface in terms of the language of the model and make sure the operation name is part of the UBIQUITOUS LANGUAGE. Make the SERVICE stateless.

> 当领域中的某个重要的过程或转换操作不是ENTITY或VALUE OBJECT的自然职责时，应该在模型中添加一个作为独立接口的操作，并将其声明为SERVICE。定义接口时要使用模型语言，并确保操作名称是UBIQUITOUS LANGUAGE中的术语。此外，应该使SERVICE成为无状态的。

---

### 5.4.1 SERVICES and the Isolated Domain Layer SERVICE与孤立的领域层
This pattern is focused on those SERVICES that have an important meaning in the domain in their own right, but of course SERVICES are not used only in the domain layer. It takes care to distinguish SERVICES that belong to the domain layer from those of other layers, and to factor responsibilities to keep that distinction sharp.

> 这种模式只重视那些在领域中具有重要意义的SERVICE，但SERVICE并不只是在领域层中使用。我们需要注意区分属于领域层的SERVICE和那些属于其他层的SERVICE，并划分责任，以便将它们明确地区分开。

Most SERVICES discussed in the literature are purely technical and belong in the infrastructure layer. Domain and application SERVICES collaborate with these infrastructure SERVICES. For example, a bank might have an application that sends an e-mail to a customer when an account balance falls below a specific threshold. The interface that encapsulates the e-mail system, and perhaps alternate means of notification, is a SERVICE in the infrastructure layer.

> 文献中所讨论的大多数SERVICE是纯技术的SERVICE，它们都属于基础设施层。领域层和应用层的SERVICE与这些基础设施层SERVICE进行协作。例如，银行可能有一个用于向客户发送电子邮件的应用程序，当客户的账户余额小于一个特定的临界值时，这个程序就向客户发送一封电子邮件。封装了电子邮件系统的接口（也可能是其他的通知方式）就是基础设施层中的SERVICE。

It can be harder to distinguish application SERVICES from domain SERVICES. The application layer is responsible for ordering the notification. The domain layer is responsible for determining if a threshold was met—though this task probably does not call for a SERVICE, because it would fit the responsibility of an “account” object. That banking application could be responsible for funds transfers. If a SERVICE were devised to make appropriate debits and credits for a funds transfer, that capability would belong in the domain layer. Funds transfer has a meaning in the banking domain language, and it involves fundamental business logic. Technical SERVICES should lack any business meaning at all.

> 应用层SERVICE和领域层SERVICE可能很难区分。应用层负责通知的设臵，而领域层负责确定是否满足临界值，尽管这项任务可能并不需要使用SERVICE，因为它可以作为“account”（账户）对象的职责中。这个银行应用程序可能还负责资金转账。如果设计一个SERVICE来处理资金转账相应的借方和贷方，那么这项功能将属于领域层。资金转账在银行领域语言中是一项有意义的操作，而且它涉及基本的业务逻辑。而纯技术的SERVICE应该没有任何业务意义。

Many domain or application SERVICES are built on top of the populations of ENTITIES and VALUES, behaving like scripts that organize the potential of the domain to actually get something done. ENTITIES and VALUE OBJECTS are often too fine-grained to provide a convenient access to the capabilities of the domain layer. Here we encounter a very fine line between the domain layer and the application layer. For example, if the banking application can convert and export our transactions into a spreadsheet file for us to analyze, that export is an application SERVICE. There is no meaning of “file formats” in the domain of banking, and there are no business rules involved.

> 很多领域或应用层SERVICE是在ENTITY和VALUE OBJECT的基础上建立起来的，它们的行为类似于将领域的一些潜在功能组织起来以执行某种任务的脚本。ENTITY和VALUE OBJECT往往由于粒度过细而无法提供对领域层功能的便捷访问。我们在这里会遇到领域层与应用层之间很微妙的分界线。例如，如果银行应用程序可以把我们的交易进行转换并导出到一个电子表格文件中，以便进行分析，那么这个导出操作就是应用层SERVICE。“文件格式”在银行领域中是没有意义的，它也不涉及业务规则。


On the other hand, a feature that can transfer funds from one account to another is a domain SERVICE because it embeds significant business rules (crediting and debiting the appropriate accounts, for example) and because a “funds transfer” is a meaningful banking term. In this case, the SERVICE does not do much on its own; it would ask the two Account objects to do most of the work. But to put the “transfer” operation on the Account object would be awkward, because the operation involves two accounts and some global rules.

> 另一方面，账户之间的转账功能属于领域层SERVICE，因为它包含重要的业务规则（如处理相应的借方账户和贷方账户），而且“资金转账”是一个有意义的银行术语。在这种情况下，SERVICE自己并不会做太多的事情，而只是要求两个Account对象完成大部分工作。但如果将“转账”操作强加在Account对象上会很别扭，因为这个操作涉及两个账户和一些全局规则。

We might like to create a Funds Transfer object to represent the two entries plus the rules and history around the transfer. But we are still left with calls to SERVICES in the interbank networks. What’s more, in most development systems, it is awkward to make a direct interface between a domain object and external resources. We can dress up such external SERVICES with a FACADE that takes inputs in terms of the model, perhaps returning a Funds Transfer object as its result. But whatever intermediaries we might have, and even though they don’t belong to us, those SERVICES are carrying out the domain responsibility of funds transfer.

> 我们可能喜欢创建一个Funds Transfer（资金转账）对象来表示两个账户，外加一些与转账有关的规则和历史记录。但在银行间的网络中进行转账时，仍然需要使用SERVICE。此外，在大多数开发系统中，在一个领域对象和外部资源之间直接建立一个接口是很别扭的。我们可以利用一个FACADE（外观）[插图]将这样的外部SERVICE包装起来，这个外观可能以模型作为输入，并返回一个“Funds Transfer”对象（作为它的结果）。但无论中间涉及什么SERVICE，甚至那些超出我们掌控范围的SERVICE，这些SERVICE都是在履行资金转账的领域职责。

Partitioning Services into Layers

> 将SERVICE划分到各个层中

Image
### 5.4.2 Granularity 粒度
Although this pattern discussion has emphasized the expressiveness of modeling a concept as a SERVICE, the pattern is also valuable as a means of controlling granularity in the interfaces of the domain layer, as well as decoupling clients from the ENTITIES and VALUE OBJECTS.

> 上述对SERVICE的讨论强调的是将一个概念建模为SERVICE的表现力，但SERVICE还有其他有用的功能，它可以控制领域层中的接口的粒度，并且避免客户端与ENTITY和VALUE OBJECT耦合。

Medium-grained, stateless SERVICES can be easier to reuse in large systems because they encapsulate significant functionality behind a simple interface. Also, fine-grained objects can lead to inefficient messaging in a distributed system.

> 在大型系统中，中等粒度的、无状态的SERVICE更容易被复用，因为它们在简单的接口背后封装了重要的功能。此外，细粒度的对象可能导致分布式系统的消息传递的效率低下。

As previously discussed, fine-grained domain objects can contribute to knowledge leaks from the domain into the application layer, where the domain object’s behavior is coordinated. The complexity of a highly detailed interaction ends up being handled in the application layer, allowing domain knowledge to creep into the application or user interface code, where it is lost from the domain layer. The judicious introduction of domain services can help maintain the bright line between layers.

> 如前所述，由于应用层负责对领域对象的行为进行协调，因此细粒度的领域对象可能会把领域层的知识泄漏到应用层中。这产生的结果是应用层不得不处理复杂的、细致的交互，从而使得领域知识蔓延到应用层或用户界面代码当中，而领域层会丢失这些知识。明智地引入领域层服务有助于在应用层和领域层之间保持一条明确的界限。

This pattern favors interface simplicity over client control and versatility. It provides a medium grain of functionality very useful in packaging components of large or distributed systems. And sometimes a SERVICE is the most natural way to express a domain concept.

> 这种模式有利于保持接口的简单性，便于客户端控制并提供了多样化的功能。它提供了一种在大型或分布式系统中便于对组件进行打包的中等粒度的功能。而且，有时SERVICE是表示领域概念的最自然的方式。

### 5.4.3 Access to SERVICES 对SERVICE的访问
Distributed system architectures, such as J2EE and CORBA, provide special publishing mechanisms for SERVICES, with conventions for their use, and they add distribution and access capabilities. But such frameworks are not always in use on a project, and even when they are, they are likely to be overkill when the motivation is just a logical separation of concerns.

> 像J2EE和CORBA这样的分布式系统架构提供了特殊的SERVICE发布机制，这些发布机制具有一些使用上的惯例，并且增加了发布和访问功能。但是，并非所有项目都会使用这样的框架，即使在使用了它们的时候，如果只是为了在逻辑上实现关注点的分离，那么它们也是大材小用了。

The means of providing access to a SERVICE is not as important as the design decision to carve off specific responsibilities. A “doer” object may be satisfactory as an implementation of a SERVICE’s interface. A simple SINGLETON (Gamma et al. 1995) can be written easily to provide access. Coding conventions can make it clear that these objects are just delivery mechanisms for SERVICE interfaces, and not meaningful domain objects. Elaborate architectures should be used only when there is a real need to distribute the system or otherwise draw on the framework’s capabilities.

> 与分离特定职责的设计决策相比，提供对SERVICE的访问机制的意义并不是十分重大。一个“操作”对象可能足以作为SERVICE接口的实现。我们很容易编写一个简单的SINGLETON对象[Gamma et al. 1995]来实现对SERVICE的访问。从编码惯例可以明显看出，这些对象只是SERVICE接口的提供机制，而不是有意义的领域对象。只有当真正需要实现分布式系统或充分利用框架功能的情况下才应该使用复杂的架构。

## 5.5 MODULES (A.K.A. PACKAGES) 模式：MODULE（也称为PACKAGE）
MODULES are an old, established design element. There are technical considerations, but cognitive overload is the primary motivation for modularity. MODULES give people two views of the model: They can look at detail within a MODULE without being overwhelmed by the whole, or they can look at relationships between MODULES in views that exclude interior detail.

> MODULE是一个传统的、较成熟的设计元素。虽然使用模块有一些技术上的原因，但主要原因却是“认知超载”[插图]。MODULE为人们提供了两种观察模型的方式，一是可以在MODULE中查看细节，而不会被整个模型淹没，二是观察MODULE之间的关系，而不考虑其内部细节。

The MODULES in the domain layer should emerge as a meaningful part of the model, telling the story of the domain on a larger scale.

> 领域层中的MODULE应该成为模型中有意义的部分，MODULE从更大的角度描述了领域。


---


Everyone uses MODULES, but few treat them as a full-fledged part of the model. Code gets broken down into all sorts of categories, from aspects of the technical architecture to developers’ work assignments. Even developers who refactor a lot tend to content themselves with MODULES conceived early in the project.

> 每个人都会使用MODULE，但却很少有人把它们当做模型中的一个成熟的组成部分。代码按照各种各样的类别进行分解，有时是按照技术架构来分割的，有时是按照开发人员的任务分工来分割的。甚至那些从事大量重构工作的开发人员也倾向于使用项目早期形成的一些MODULE。

It is a truism that there should be low coupling between MODULES and high cohesion within them. Explanations of coupling and cohesion tend to make them sound like technical metrics, to be judged mechanically based on the distributions of associations and interactions. Yet it isn’t just code being divided into MODULES, but concepts. There is a limit to how many things a person can think about at once (hence low coupling). Incoherent fragments of ideas are as hard to understand as an undifferentiated soup of ideas (hence high cohesion).

> 众所周知，MODULE之间应该是低耦合的，而在MODULE的内部则是高内聚的。耦合和内聚的解释使得MODULE听上去像是一种技术指标，仿佛是根据关联和交互的分布情况来机械地判断它们。然而，MODULE并不仅仅是代码的划分，而且也是概念的划分。一个人一次考虑的事情是有限的（因此才要低耦合）。不连贯的思想和“一锅粥”似的思想同样难于理解（因此才要高内聚）。

Low coupling and high cohesion are general design principles that apply as much to individual objects as to MODULES, but they are particularly important at this larger grain of modeling and design. These terms have been around for a long time; one patterns-style explanation can be found in Larman 1998.

> 低耦合高内聚作为通用的设计原则既适用于各种对象，也适用于MODULE，但MODULE作为一种更粗粒度的建模和设计元素，采用低耦合高内聚原则显得更为重要。这些术语由来已久，早在[Larman 1998]中就从模式角度对其进行了解释。

Whenever two model elements are separated into different modules, the relationships between them become less direct than they were, which increases the overhead of understanding their place in the design. Low coupling between MODULES minimizes this cost, and makes it possible to analyze the contents of one MODULE with a minimum of reference to others that interact.

> 只要两个模型元素被划分到不同的MODULE中，它们的关系就不如原来那样直接，这会使我们更难理解它们在设计中的作用。MODULE之间的低耦合可以将这种负面作用减至最小，而且在分析一个MODULE的内容时，只需很少地参考那些与之交互的其他MODULE。

At the same time, the elements of a good model have synergy, and well-chosen MODULES bring together elements of the model with particularly rich conceptual relationships. This high cohesion of objects with related responsibilities allows modeling and design work to concentrate within a single MODULE, a scale of complexity a human mind can easily handle.

> 同时，在一个好的模型中，元素之间是要协同工作的，而仔细选择的MODULE可以将那些具有紧密概念关系的模型元素集中到一起。将这些具有相关职责的对象元素聚合到一起，可以把建模和设计工作集中到单一MODULE中，这会极大地降低建模和设计的复杂性，使人们可以从容应对这些工作。

MODULES and the smaller elements should coevolve, but typically they do not. MODULES are chosen to organize an early form of the objects. After that, the objects tend to change in ways that keep them in the bounds of the existing MODULE definition. Refactoring MODULES is more work and more disruptive than refactoring classes, and probably can’t be as frequent. But just as model objects tend to start out naive and concrete and then gradually transform to reveal deeper insight, MODULES can become subtle and abstract. Letting the MODULES reflect changing understanding of the domain will also allow more freedom for the objects within them to evolve.

> MODULE和较小的元素应该共同演变，但实际上它们并不是这样。MODULE被用来组织早期对象。在这之后，对象在变化时不脱离现有模块定义的边界。重构MODULE需要比重构类做更多工作，也具有更大的破坏性，并且可能不会特别频繁。但就像模型对象从简单具体逐渐转变为反映更深层次的本质一样，MODULE也会变得微妙和抽象。让MODULE反映出对领域理解的不断变化，可以使MODULE中的对象能够更自由地演变。

Like everything else in a domain-driven design, MODULES are a communications mechanism. The meaning of the objects being partitioned needs to drive the choice of MODULES. When you place some classes together in a MODULE, you are telling the next developer who looks at your design to think about them together. If your model is telling a story, the MODULES are chapters. The name of the MODULE conveys its meaning. These names enter the UBIQUITOUS LANGUAGE. “Now let’s talk about the ‘customer’ module,” you might say to a business expert, and the context is set for your conversation.

> 像领域驱动设计中的其他元素一样，MODULE是一种表达机制。MODULE的选择应该取决于被划分到模块中的对象的意义。当你将一些类放到MODULE中时，相当于告诉下一位看到你的设计的开发人员要把这些类放在一起考虑。如果说模型讲述了一个故事，那么MODULE就是这个故事的各个章节。模块的名称表达了其意义。这些名称应该被添加到UBIQUITOUS LANGUAGE中。你可能会向一位业务专家说“现在让我们讨论一下‘客户’模块”，这就为你们接下来的对话设定了上下文。

Therefore:

> 因此：

Choose MODULES that tell the story of the system and contain a cohesive set of concepts. This often yields low coupling between MODULES, but if it doesn’t, look for a way to change the model to disentangle the concepts, or search for an overlooked concept that might be the basis of a MODULE that would bring the elements together in a meaningful way. Seek low coupling in the sense of concepts that can be understood and reasoned about independently of each other. Refine the model until it partitions according to high-level domain concepts and the corresponding code is decoupled as well.

> 选择能够描述系统的MODULE，并使之包含一个内聚的概念集合。这通常会实现MODULE之间的低耦合，但如果效果不理想，则应寻找一种更改模型的方式来消除概念之间的耦合，或者找到一个可作为MODULE基础的概念（这个概念先前可能被忽视了），基于这个概念组织的MODULE可以以一种有意义的方式将元素集中到一起。找到一种低耦合的概念组织方式，从而可以相互独立地理解和分析这些概念。对模型进行精化，直到可以根据高层领域概念对模型进行划分，同时相应的代码也不会产生耦合。

Give the MODULES names that become part of the UBIQUITOUS LANGUAGE. MODULES and their names should reflect insight into the domain.

> MODULE的名称应该是UBIQUITOUS LANGUAGE中的术语。MODULE及其名称应反映出领域的深层知识。

Looking at conceptual relationships is not an alternative to technical measures. They are different levels of the same issue, and both have to be accomplished. But model-focused thinking produces a deeper solution, rather than an incidental one. And when there has to be a trade-off, it is best to go with the conceptual clarity, even if it means more references between MODULES or occasional ripple effects when changes are made to a MODULE. Developers can handle these problems if they understand the story the model is telling them.

> 仅仅研究概念关系是不够的，它并不能替代技术措施。这二者是相同问题的不同层次，都是必须要完成的。但是，只有以模型为中心进行思考，才能得到更深层次的解决方案，而不是随便找一个解决方案应付了事。当必须做出一个折中选择时，务必保证概念清晰，即使这意味着MODULE之间会产生更多引用，或者更改MODULE偶尔会产生“涟漪效应”。开发人员只要理解了模型所描述的内容，就可以应付这些问题。

---

### 5.5.1 Agile MODULES 敏捷的MODULE
MODULES need to coevolve with the rest of the model. This means refactoring MODULES right along with the model and code. But this refactoring often doesn’t happen. Changing MODULES tends to require widespread updates to the code. Such changes can be disruptive to team communication and can even throw a monkey wrench into development tools, such as source code control systems. As a result, MODULE structures and names often reflect much earlier forms of the model than the classes do.

> MODULE需要与模型的其他部分一同演变。这意味着MODULE的重构必须与模型和代码一起进行。但这种重构通常不会发生。更改MODULE可能需要大范围地更新代码。这些更改可能会对团队沟通起到破坏作用，甚至会妨碍开发工具（如源代码控制系统）的使用。因此，MODULE结构和名称往往反映了模型的较早形式，而类则不是这样。

Inevitable early mistakes in MODULE choices lead to high coupling, which makes it hard to refactor. The lack of refactoring just keeps increasing the inertia. It can only be overcome by biting the bullet and reorganizing MODULES based on experience of where the trouble spots lie.

> 在MODULE选择的早期，有些错误是不可避免的，这些错误导致了高耦合，从而使MODULE很难进行重构。而缺乏重构又会导致问题变得更加严重。克服这一问题的唯一方法是接受挑战，仔细地分析问题的要害所在，并据此重新组织MODULE。

Some development tools and programming systems exacerbate the problem. Whatever development technology the implementation will be based on, we need to look for ways of minimizing the work of refactoring MODULES, and minimizing clutter in communicating to other developers.

> 一些开发工具和编程系统会使问题变得更加严重。无论在实现中采用哪种开发技术，我们要想尽一切办法来减少重构MODULE的工作量，并最大限度地减少与其他开发人员沟通时出现的混乱情况。

Example: Package Coding Conventions in Java

> 示例Java中的包编码惯例

In Java, imports (dependencies) must be declared in some individual class. A modeler probably thinks of packages as depending on other packages, but this can’t be stated in Java. Common coding conventions encourage the import of specific classes, resulting in code like this:

> 在Java中，类使用impor语句来声明依赖。建模人员可能认为有些包会依赖其他的包，但在Java中无法说明这一点。常见的编码惯例鼓励导入具体的类，如以下代码所示：

```java
ClassA1
import packageB.ClassB1;
import packageB.ClassB2;
import packageB.ClassB3;
import packageC.ClassC1;
import packageC.ClassC2;
import packageC.ClassC3;
. . .
```
In Java, unfortunately, there is no escape from importing into individual classes, but you can at least import entire packages at a time, reflecting the intention that packages are highly cohesive units while simultaneously reducing the effort of changing package names.

> 遗憾的是，在Java中，我们不可避免地需要在类中使用import声明依赖，但至少可以一次导入一个完整的包，这既反映出包是一种高内聚的单元，同时又减少了更改包名称的工作量。
```java
ClassA1
import packageB.*;
import packageC.*;
. . .
```
True, this technique means mixing two scales (classes depend on packages), but it communicates more than the previous voluminous list of classes—it conveys the intent to create a dependency on particular MODULES.

> 的确，这种技术意味着把类和包混在一起（类依赖于包），但它除了表达前面一长串类的列表之外，还表达了在具体MODULE上建立一种依赖性的意图。

If an individual class really does depend on a specific class in another package, and the local MODULE doesn’t seem to have a conceptual dependency on the other MODULE, then maybe a class should be moved, or the MODULES themselves should be reconsidered.

> 如果一个类确实依赖于另一个包中的某个类，而且本地MODULE对该MODULE并没有概念上的依赖关系，那么或许应该移动一个类，或者考虑重新组织MODULE。

### 5.5.2 The Pitfalls of Infrastructure-Driven Packaging 通过基础设施打包时存在的隐患
Strong forces on our packaging decisions come from technical frameworks. Some of these are helpful, while others need to be resisted.

> 技术框架对打包决策有着极大的影响，有些技术框架是有帮助的，有些则要坚决抵制。

An example of a very useful framework standard is the enforcement of LAYERED ARCHITECTURE by placing infrastructure and user interface code into separate groups of packages, leaving the domain layer physically separated into its own set of packages.

> 一个非常有用的框架标准是LAYERED ARCHITECTURE，它将基础设施和用户界面代码放到两组不同的包中，并且从物理上把领域层隔离到它自己的一组包中。

On the other hand, tiered architectures can fragment the implementation of the model objects. Some frameworks create tiers by spreading the responsibilities of a single domain object across multiple objects and then placing those objects in separate packages. For example, with J2EE a common practice is to place data and data access into an “entity bean” while placing associated business logic into a “session bean.” In addition to the increased implementation complexity of each component, the separation immediately robs an object model of cohesion. One of the most fundamental concepts of objects is to encapsulate data with the logic that operates on that data. This kind of tiered implementation is not fatal, because both components can be viewed as together constituting the implementation of a single model element, but to make matters worse, the entity and session beans are often separated into different packages. At that point, viewing the various objects and mentally fitting them back together as a single conceptual ENTITY is just too much effort. We lose the connection between the model and design. Best practice is to use EJBs at a larger grain than ENTITY objects, reducing the downside of separating tiers. But fine-grain objects are often split into tiers also.

> 但从另一个方面看，分层架构可能导致模型对象实现的分裂。一些框架的分层方法是把一个领域对象的职责分散到多个对象当中，然后把这些对象放到不同的包中。例如，当使用J2EE早期版本时，一种常见的做法是把数据和数据访问放到“实体bean”中，而把相关的业务逻辑放到“会话bean”中。这样做除了导致每个组件的实现变得更复杂以外，还破坏了对象模型的内聚性。对象的一个最基本的概念是将数据和操作这些数据的逻辑封装在一起。由于我们可以把这两个组件看作是一起组成一个单一模型元素的实现，因此这种分层实现还不算是致命的。但实体bean和会话bean通常被隔离到不同的包中，从而使情况变得更糟。在这种情况下，通过查看若干对象并把它们脑补成单一的概念ENTITY是非常困难的。我们失去了模型与设计之间的联系。最好的做法是在比ENTITY对象更大的粒度上应用EJB，从而减少分层的副作用。但细粒度的对象通常也会被分层。

For example, I encountered these problems on a rather intelligently run project in which each conceptual object was actually broken into four tiers. Each division had a good rationale. The first tier was a data persistence layer, handling mapping and access to the relational database. Then came a layer that handled behavior intrinsic to the object in all situations. Next was a layer for superimposing application-specific functionality. The fourth tier was meant as a public interface, decoupled from all the implementation below. This scheme was a bit too complicated, but the layers were well defined and there was some tidiness to the separation of concerns. We could have lived with mentally connecting all the physical objects making up one conceptual object. The separation of aspects even helped at times. In particular, having the persistence code moved out removed a lot of clutter.

> 例如，我就曾经在一个筹划得相当不错的项目上遇到过这些问题，这个项目的每个概念模型实际上被分为4层。每个层的划分都有很好的理由。第一层是数据持久层，负责处理映射和访问关系数据库。第二层负责处理对象在所有情况下的固有行为。第三层放臵特定于应用程序的功能。第四层是一个公共接口，它隐藏了第一、二、三层的所有实现细节。这种分层方案有些复杂，但每层都有很好的定义，而且清楚地实现了关注点的分离。我们可以在大脑中将所有物理对象连接到一起，组成一个概念对象。有时，方面的分离也是有帮助的。具体来讲，把持久化代码移出来可以减少很多混乱。

But on top of all this, the framework required each tier to be in a separate set of packages, named according to a convention that identified the tier. This took up all the mental room for partitioning. As a result, domain developers tended to avoid making too many MODULES (each of which was multiplied by four) and hardly ever changed one, because the effort of refactoring a MODULE was prohibitive. Worse, hunting down all the data and behavior that defined a single conceptual class was so difficult (combined with the indirectness of the layering) that developers didn’t have much mental space left to think about models. The application was delivered, but with an anemic domain model that basically fulfilled the database access requirements of the application, with behavior supplied by a few SERVICES. The leverage that should have derived from MODEL-DRIVEN DESIGN was limited because the code did not transparently reveal the model and allow a developer to work with it.

> 但最重要的是，这个项目的框架要求将每个层放到单独的一组包中，并根据层的标识惯例来命名。这一下子就把我们所有的注意力都吸引到分层上来。结果，领域开发人员尽量避免创建太多的MODULE（每个模块都要乘以4），而且几乎不能更改模块，因为重构MODULE的工作量不允许这样做。更糟的是，由于很难跟踪定义了一个概念类的所有数据和行为（而且还要考虑分层产生的间接关系），因此开发人员没有多少精力思考模型了。这个应用最终交付使用了，但它使用了贫血领域模型，只是基本满足了应用程序的数据库访问需求，此外通过很少的几个SERVICE提供了一些行为。这个项目从MODEL-DRIVEN DESIGN获得的益处十分有限，因为代码并没有清晰地揭示模型，因此开发人员也无法充分地利用模型。

This kind of framework design is attempting to address two legitimate issues. One is the logical division of concerns: One object has responsibility for database access, another for business logic, and so on. Such divisions make it easier to understand the functioning of each tier (on a technical level) and make it easier to switch out layers. The trouble is that the cost to application development is not recognized. This is not a book on framework design, so I won’t go into alternative solutions to that problem, but they do exist. And even if there were no options, it would be better to trade off these benefits for a more cohesive domain layer.

> 这种框架设计是在尝试解决两个合理的问题。一个问题是关注点的逻辑划分：一个对象负责数据库访问，另外一个对象负责处理业务逻辑，等等。这种划分方法使人们更容易（在技术层面上）理解每个层的功能，而且更容易切换各个层。这种设计的问题在于没有顾及应用程序的开发成本。本书不是讨论框架设计的书，因此不会给出此问题的替代解决方案，但它们确实存在。而且，即使别无选择，也值得牺牲一些分层的好处来换取更内聚的领域层。


The other motivation for these packaging schemes is the distribution of tiers. This could be a strong argument if the code actually got deployed on different servers. Usually it does not. The flexibility is sought just in case it is needed. On a project that hopes to get leverage from MODEL-DRIVEN DESIGN, this sacrifice is too great unless it solves an immediate and pressing problem.

> 这些打包方案的另一个动机是层的分布。如果代码实际上被部署到不同的服务器上，那么这会成为这种分层的有力论据。但通常并不是这样。应该在需要时才寻求灵活性。在一个希望充分利用MODEL-DRIVEN DESIGN的项目上，这种分层设计的牺牲太大了，除非它是为了解决一个紧迫的问题。

Elaborate technically driven packaging schemes impose two costs.

> 精巧的技术打包方案会产生如下两个代价。

- If the framework’s partitioning conventions pull apart the elements implementing the conceptual objects, the code no longer reveals the model.
- There is only so much partitioning a mind can stitch back together, and if the framework uses it all up, the domain developers lose their ability to chunk the model into meaningful pieces.

---


> - 如果框架的分层惯例把实现概念对象的元素分得很零散，那么代码将无法再清楚地表示模型。
> - 人的大脑把划分后的东西还原成原样的能力是有限的，如果框架把人的这种能力都耗尽了，那么领域开发人员就无法再把模型还原成有意义的部分了。

It is best to keep things simple. Choose a minimum of technical partitioning rules that are essential to the technical environment or actually aid development. For example, decoupling complicated data persistence code from the behavioral aspects of the objects may make refactoring easier.

> 最好把事情变简单。要极度简化技术分层规则，要么这些规则对技术环境特别重要，要么这些规则真正有助于开发。例如，将复杂的数据持久化代码从对象的行为方面提取出来可以使重构变得更简单。

Unless there is a real intention to distribute code on different servers, keep all the code that implements a single conceptual object in the same MODULE, if not the same object.

> 除非真正有必要将代码分布到不同的服务器上，否则就把实现单一概念对象的所有代码放在同一个模块中（如果不能放在同一个对象中的话）。

We could have come to the same conclusion by drawing on the old standard, “high cohesion/low coupling.” The connections between an “object” implementing the business logic and the one responsible for database access are so extensive that the coupling is very high.

> 从传统的“高内聚、低耦合”标准也可以得出相同的结论。实现业务逻辑的对象与负责数据库访问的对象之间的联系非常广泛，因此它们之间的耦合度很高。

There are other pitfalls where framework design or just conventions of a company or project can undermine MODEL-DRIVEN DESIGN by obscuring the natural cohesion of the domain objects, but the bottom line is the same. The restrictions, or just the large number of required packages, rules out the use of other packaging schemes that are tailored to the needs of the domain model.

> 在框架设计中，或者在公司或项目的工作惯例方面，可能还有其他一些隐患，这些隐患可能会妨碍领域模型的自然内聚性，从而破坏模型驱动的设计，但所有隐患的基本问题都是相同的。种种限制（或者只是由于所需的包太多了）使我们无法使用专门根据领域模型需要量身定做的其他打包方案。

Use packaging to separate the domain layer from other code. Otherwise, leave as much freedom as possible to the domain developers to package the domain objects in ways that support their model and design choices.

> 利用打包把领域层从其他代码中分离出来。否则，就尽可能让领域开发人员自由地决定领域对象的打包方式，以便支持他们的模型和设计选择。

One exception arises when code is generated based on a declarative design (discussed in Chapter 10). In that case, the developers do not need to read the code, and it is better to put it into a separate package so that it is out of the way, not cluttering up the design elements developers actually have to work with.

> 如果代码是基于声明式设计（第10章有这方面的讨论）生成的，则是一种例外情况。在这种情况下，开发人员无需阅读代码，因此为了不碍事最好将代码放到一个单独的包中，这样就不会搞乱开发人员实际要处理的设计元素。

Modularity becomes more critical as the design gets bigger and more complex. This section presents the basic considerations. Much of Part IV, “Strategic Design,” provides approaches to packaging and breaking down big models and designs, and ways to give people focal points to guide understanding.

> 随着设计规模和复杂度的增加，模块化变得更加重要。本节只是介绍了一些基本的注意事项。本书第四部分主要介绍打包方法以及分解大型模型和设计的方法，并介绍如何抓住重点以帮助理解问题。

Each concept from the domain model should be reflected in an element of implementation. The ENTITIES, VALUE OBJECTS, and their associations, along with a few domain SERVICES and the organizing MODULES, are points of direct correspondence between the implementation and the model. The objects, pointers, and retrieval mechanisms in the implementation must map to model elements straightforwardly, obviously. If they do not, clean up the code, go back and change the model, or both.

> 领域模型中的每个概念都应该在实现元素中反映出来。ENTITY、VALUE OBJECT、它们之间的关联、领域SERVICE以及用于组织元素的MODULE都是实现与模型直接对应的地方。实现中的对象、指针和检索机制必须直接、清楚地映射到模型元素。如果没有做到这一点，就要重写代码，或者回头修改模型，或者同时修改代码和模型。

Resist the temptation to add anything to the domain objects that does not closely relate to the concepts they represent. These design elements have their job to do: they express the model. There are other domain-related responsibilities that must be carried out and other data that must be managed in order to make the system work, but they don’t belong in these objects. In Chapter 6, I will discuss some supporting objects that fulfill the technical responsibilities of the domain layer, such as defining database searches and encapsulating complex object creation.

> 不要在领域对象中添加任何与领域对象所表示的概念没有紧密关系的元素。领域对象的职责是表示模型。当然，其他一些与领域有关的职责也是必须要实现的，而且为了使系统工作，也必须管理其他数据，但它们不属于领域对象。第6章将讨论一些支持对象，这些对象履行领域层的技术职责，如定义数据库搜索和封装复杂的对象创建。

The four patterns in this chapter provide the building blocks for an object model. But MODEL-DRIVEN DESIGN does not necessarily mean forcing everything into an object mold. There are also other model paradigms supported by tools, such as rules engines. Projects have to make pragmatic trade-offs between them. These other tools and techniques are means to the end of a MODEL-DRIVEN DESIGN, not alternatives to it.

> 本章介绍的4种模式为对象模型提供了构造块。但MODEL-DRIVEN DESIGN并不是说必须将每个元素都建模为对象。一些工具还支持其他的模型范式，如规则引擎。项目需要在它们之间做出契合实际的折中选择。这些其他的工具和技术是MODEL-DRIVEN DESIGN的补充，而不是要取而代之。

## 5.6 MODELING PARADIGMS 建模范式
MODEL-DRIVEN DESIGN calls for an implementation technology in tune with the particular modeling paradigm being applied. Many such paradigms have been experimented with, but only a few have been widely used in practice. At present, the dominant paradigm is object-oriented design, and most complex projects these days set out to use objects. This predominance has come about for a variety of reasons: some factors are intrinsic to objects, some are circumstantial, and others derive from the advantages that come from wide usage itself.

> MODEL-DRIVEN DESIGN要求使用一种与建模范式协调的实现技术。人们曾经尝试了大量的建模范式，但在实践中只有少数几种得到了广泛应用。目前，主流的范式是面向对象设计，而且现在的大部分复杂项目都开始使用对象。这种范式的流行有许多原因，包括对象本身的固有因素、一些环境因素，以及广泛使用所带来的一些优势。

### 5.6.1 Why the Object Paradigm Predominates 对象范式流行的原因
Many of the reasons teams choose the object paradigm are not technical, or even intrinsic to objects. But right out of the gate, object modeling does strike a nice balance of simplicity and sophistication.

> 一些团队选择对象范式并不是出于技术上的原因，甚至也不是出于对象本身的原因，而是从一开始，对象建模就在简单性和复杂性之间实现了一个很好的平衡。

If a modeling paradigm is too esoteric, not enough developers will master it, and they will use it badly. If the nontechnical members of the team can’t grasp at least the rudiments of the paradigm, they will not understand the model, and the UBIQUITOUS LANGUAGE will be lost. The fundamentals of object-oriented design seem to come naturally to most people. Although some developers miss the subtleties of modeling, even nontechnologists can follow a diagram of an object model.

> 如果一个建模范式过于深奥，那么大多数开发人员可能无法掌握它，因此也无法正确地运用它。如果团队中的非技术人员无法掌握范式的基本知识，那么他们将无法理解模型，以至于无法建立UBIQUITOUS LANGUAGE。大部分人都比较容易理解面向对象设计的基本知识。尽管一些开发人员还没有完全领悟建模的奥妙，但即使是非专业人员也可以理解对象模型图。

Yet, simple as the concept of object modeling is, it has proven rich enough to capture important domain knowledge. And it has been supported from the outset by development tools that allowed a model to be expressed in software.

> 然而，虽然对象建模的概念很简单，但它的丰富功能足以捕获重要的领域知识。而且它从一开始就获得了开发工具的支持，使得模型可以在软件中表达出来。

Today, the object paradigm also has some significant circumstantial advantages deriving from maturity and widespread adoption. Without mature infrastructure and tool support, a project can get sidetracked into technological R&D, delaying and diverting resources away from application development and introducing technical risks. Some technologies don’t play well with others, and it may not be possible to integrate them with industry-standard solutions, forcing the team to reinvent common utilities. But over the years, many of these problems have been solved for objects, or made irrelevant by widespread adoption. (Now it falls on other approaches to integrate with mainstream object technology.) Most new technologies provide the means to integrate with the popular object-oriented platforms. This makes integration easier and even leaves open the option of mixing in subsystems based on other modeling paradigms (which we will discuss later in this chapter).

> 现在，对象范式已经发展很成熟并得到了广泛采用，这使得它具有明显的优势。项目如果没有成熟的基础设施和工具支持，可能就要在这些方面进行研发工作，这不仅会耽误应用程序的开发，分散应用程序的开发资源，还会带来技术风险。有些技术不能与其他技术很好地协同工作，而且它们可能也无法与行业标准解决方案集成，这使团队不得不重新开发一些常用的辅助工具。但近年来，很多这样的问题已经在对象领域得以解决，而且有些问题也随着对象范式的广泛采用而变得无关紧要（现在，对象技术已经成为主流，因此集成的任务已经落到其他方法的肩上）。大多数新技术都提供了与主流的面向对象平台进行集成的方式。这使得集成更容易，甚至允许将基于其他建模范式的子系统混合在一起（本章稍后将讨论）。

Equally important is the maturity of the developer community and the design culture itself. A project that adopts a novel paradigm may be unable to find developers with expertise in the technology, or with the experience to create effective models in the chosen paradigm. It may not be feasible to educate developers in a reasonable amount of time because the patterns for making the most of the paradigm and technology haven’t gelled yet. Perhaps the pioneers of the field are effective but haven’t yet published their insights in an accessible form.

> 开发者社区和设计文化的成熟也同样重要。采用新范式的项目可能很难找到精通它的开发人员，也很难找到能够使用新范式创建有效模型的人员。要想在短时间内培训开发人员使用新范式往往是行不通的，因为能够最大限度地利用新范式和技术的模式尚未形成。或许新领域的一些开拓者已经可以有效地使用新范式，但他们尚未发布可供人们学习的知识。

Objects are already understood by a community of thousands of developers, project managers, and all the other specialists involved in project work.

> 而对象范式则不同，大多数开发人员、项目经理和从事项目工作的其他专家都已经很了解它。

A story from an object-oriented project of only a decade ago illustrates the risks of working in an immature paradigm. In the early 1990s, this project committed itself to several cutting-edge technologies, including use of an object-oriented database on a large scale. It was exciting. People on the team would proudly tell visitors that we were deploying the biggest database this technology had ever supported. When I joined the project, different teams were spinning out object-oriented designs and storing their objects in the database effortlessly. But gradually the realization crept upon us that we were beginning to absorb a significant fraction of the database’s capacity—with test data! The actual database would be dozens of times larger. The actual transaction volume would be dozens of times higher. Was it impossible to use this technology for this application? Had we used it improperly? We were out of our depth.

> 下面我讲一个10年前在一个面向对象项目中发生的小故事，它说明了在工作中使用不成熟范式所产生的风险。这个项目是在20世纪90年代早期开始的，它采用了几种当时最前沿的技术，包括大规模使用面向对象数据库。当时这让人很兴奋。团队成员骄傲地告诉访客他们正在部署迄今为止最大的面向对象数据库。当我加盟这个项目时，各个团队正在研究一些面向对象的设计，并且可以毫不费力地将对象存储在数据库中。但我们渐渐意识到，大部分数据库容量已经被耗尽了，而这仅仅只输入了测试数据而已！实际所需的数据库还要大几十倍。实际的事务量也要大上几十倍。是不是这个应用程序根本不适合使用面向对象数据库？是我们使用不当吗？我们已经力不从心了。

Fortunately, we were able to bring onto the team one of a handful of people in the world with the skills to extricate us from the problem. He named his price and we paid it. There were three sources of the problem. First, the off-the-shelf infrastructure provided with the database simply didn’t scale up to our needs. Second, storage of fine-grained objects turned out to be much more costly than we had realized. Third, parts of the object model had such a tangle of interdependencies that contention became a problem with a relatively small number of concurrent transactions.

幸运的是，我们找到了一位精通对象数据库技术的专家来帮助我们摆脱困境。我们谈妥服务价格后，他指出了3个问题根源。首先，与数据库一起提供的基础设施没有扩展到我们所需的规模。其次，细粒度对象的存储比我们预计的代价要大得多。最后，对象模型的有些部分其内部依赖过于复杂，以至于很少的并发事务就会产生竞争问题。

With the help of this hired expert, we enhanced the infrastructure. The team, now aware of the impact of fine-grained objects, began to find models that worked better with this technology. All of us deepened our thinking about the importance of limiting the web of relationships in a model, and we began applying this new understanding to making better models with more decoupling between closely interrelated aggregates.

在这位专家的帮助下，我们对基础设施进行了强化。现在，项目团队意识到细粒度对象的影响，并开始寻找更适合对象数据库的模型。所有人员都深刻认识到对模型中的关系进行限制的重要性，我们利用这种新的理解开始设计更好的模型——将原来那些紧密联系在一起的对象解耦。

Several months were lost in this recovery, in addition to the earlier months spent going down a failed path. And this had not been the team’s first setback resulting from the immaturity of the chosen technologies and our own lack of experience with the associated learning curve. Sadly, this project eventually retrenched and became quite conservative. To this day they use the exotic technologies, but for cautiously scoped applications that probably don’t really benefit from them.

除了前几个月浪费在错误路线上以外，项目的修复又损失了好几个月的时间。而且这并不是团队由于选择了不成熟的技术和没有相关经验而遭遇的第一个挫折。遗憾的是，这个项目最终被削减了，而且变得十分保守。直到今天，他们虽然仍会使用一些外来技术，但在应用范围上变得谨小慎微，这导致他们可能无法真正从这些技术中获益。

A decade later, object-oriented technology is relatively mature. Most common infrastructure needs can be met with off-the-shelf solutions that have been used in the field. Mission-critical tools come from major vendors, often multiple vendors, or from stable open-source projects. Many of these infrastructure pieces themselves are used widely enough that there is a base of people who already understand them, as well as books explaining them, and so forth. The limitations of these established technologies are fairly well understood, so that knowledgeable teams are less likely to overreach.

> 十年过去了，面向对象技术已经相对成熟。业内已经提供了很多现成的解决方案，它们可以满足大部分常见的基础设施需要。多数大型供应商，或者稳定的开源项目都提供了关键工具。这些基础设施本身就已经被广泛使用，因此了解它们的人很多，相关书籍也很多，等等。人们已经相当了解这些成熟技术的局限性，因此内行团队也不会过度使用它们。

Other interesting modeling paradigms just don’t have this maturity. Some are too hard to master and will never be used outside small specialties. Others have potential, but the technical infrastructure is still patchy or shaky, and few people understand the subtleties of creating good models for them. These may come of age, but they are not ready for most projects.

> 其他一些令人感兴趣的建模范式并没有这么成熟。有些建模范式太难掌握了，以至于只能在很小的专业领域内使用。有些建模范式虽然有潜力，但技术基础设施仍然不够完整、可靠，而且很少有人理解为这些范式创建良好模型的诀窍。这些范式可能已经出现很长一段时间了，但仍然不适合用于大多数项目。

This is why, for the present, most projects attempting MODEL-DRIVEN DESIGN are wise to use object-oriented technology as the core of their system. They will not be locked into an object-only system—because objects have become the mainstream of the industry, integration tools are available to connect with almost any other technology in current use.

> 这就是目前大部分采用MODEL-DRIVEN DESIGN的项目很明智地使用面向对象技术作为系统核心的原因。它们不会被束缚在只有对象的系统里，因为对象已经成为内业的主流技术，人们目前使用的几乎所有的技术都有与之对应的集成工具。

Yet this doesn’t mean that people should restrict themselves to objects forever. Traveling with the crowd provides some safety, but it isn’t always the way to go. Object models address a large number of practical software problems, but there are domains that are not natural to model as discrete packets of encapsulated behavior. For example, domains that are intensely mathematical or that are dominated by global logical reasoning do not fit well into the object-oriented paradigm.

> 然而，这并不意味着人们就应该永远只局限于对象技术。随大流具有一定的安全性，但这并非总是应该走的道路。对象模型可以解决很多实际的软件问题，但也有一些领域不适合用封装了行为的各种对象来建模。例如，涉及大量数学问题的领域或者受全局逻辑推理控制的领域就不适合使用面向对象的范式

### 5.6.2 Nonobjects in an Object World 对象世界中的非对象
A domain model does not have to be an object model. There are MODEL-DRIVEN DESIGNS implemented in Prolog, for example, with a model made up of logical rules and facts. Model paradigms have been conceived to address certain ways people like to think about domains. Then the models of those domains are shaped by the paradigm. The result is a model that conforms to the paradigm so that it can be effectively implemented in the tools that support that modeling style.

> 领域模型不一定是对象模型。例如，使用Prolog语言实现的MODEL-DRIVEN DESIGN，它的模型是由逻辑规则和事实构成的。模型范式为人们提供了思考领域的方式。这些领域的模型由范式塑造成型。结果就得到了遵守范式的模型，这样的模型可以用支持对应建模风格的工具来有效地实现。

Whatever the dominant model paradigm may be on a project, there are bound to be parts of the domain that would be much easier to express in some other paradigm. When there are just a few anomalous elements of a domain that otherwise works well in a paradigm, developers can live with a few awkward objects in an otherwise consistent model. (Or, on the other extreme, if the greater part of the problem domain is more naturally expressed in a particular other paradigm, it may make sense to switch paradigms altogether and choose a different implementation platform.) But when major parts of the domain seem to belong to different paradigms, it is intellectually appealing to model each part in a paradigm that fits, using a mixture of tool sets to support implementation. When the interdependence is small, a subsystem in the other paradigm can be encapsulated, such as a complex math calculation that simply needs to be called by an object. Other times the different aspects are more intertwined, such as when the interaction of the objects depends on some mathematical relationships.

> 不管在项目中使用哪种主要的模型范式，领域中都会有一些部分更容易用某种其他范式来表达。当领域中只有个别元素适合用其他范式时，开发人员可以接受一些蹩脚的对象，以使整个模型保持一致（或者，在另一种极端的情况下，如果大部分问题领域都更适合用其他范式来表达，那么可以整个改为使用那种范式，并选择一个不同的实现平台）。但是，当领域的主要部分明显属于不同的范式时，明智的做法是用适合各个部分的范式对其建模，并使用混合工具集来进行实现。当领域的各个部分之间的互相依赖性较小时，可以把用另一种范式建立的子系统封装起来，例如，只有一个对象需要调用的复杂数学计算。其他时候，不同方面之间的关系更为复杂，例如，对象的交互依赖于某些数学关系的时候。

This is what motivates the integration into object systems of such nonobject components as business rules engines and workflow engines. Mixing paradigms allows developers to model particular concepts in the style that fits best. Furthermore, most systems must use some nonobject technical infrastructure, most commonly relational databases. But making a coherent model that spans paradigms is hard, and making the supporting tools coexist is complicated. When developers can’t clearly see a coherent model embodied in the software, MODEL-DRIVEN DESIGN can go out the window, even as this mixture increases the need for it.

> 这就是将业务规则引擎或工作流引擎这样的非对象组件集成到对象系统中的动机。混合使用不同的范式使得开发人员能够用最适当的风格对特殊概念进行建模。此外，大部分系统都必须使用一些非对象的技术基础设施，最常见的就是关系数据库。但是在使用不同的范式后，要想得到一个内聚的模型就比较难了，而且让不同的支持工具共存也较为复杂。当开发人员在软件中无法清楚地辨认出一个内聚的模型时，MODEL-DRIVEN DESIGN就会被抛诸脑后，尽管这种混合设计更需要它。

### 5.6.3 Sticking with MODEL-DRIVEN DESIGN When Mixing Paradigms 在混合范式中坚持使用MODEL-DRIVEN DESIGN
Rules engines will serve as an example of a technology sometimes mixed into an object-oriented application development project. A knowledge-rich domain model probably contains explicit rules, yet the object paradigm lacks specific semantics for stating rules and their interactions. Although rules can be modeled as objects, and often are successfully, object encapsulation makes it awkward to apply global rules that cross the whole system. Rules engine technology is appealing because it promises to provide a more natural and declarative way to define rules, effectively allowing the rules paradigm to be mixed into the object paradigm. The logic paradigm is well developed and powerful, and it seems like a good complement to the strengths and weaknesses of objects.

> 在面向对象的应用程序开发项目中，有时会混合使用一些其他的技术，规则引擎就是一个常见的例子。一个包含丰富知识的领域模型可能会含有一些显式的规则，然而对象范式却缺少用于表达规则和规则交互的具体语义。尽管可以将规则建模为对象（而且常常可以成功地做到），但对象封装却使得那些针对整个系统的全局规则很难应用。规则引擎技术非常有吸引力，因为它提供了一种更自然、声明式的规则定义方式，能够有效地将规则范式融合到对象范式中。逻辑范式已经得到了很好的发展并且功能强大，它是对象范式的很好补充，使其可以扬长避短。

But people don’t always get what they hope for out of rules engines. Some products just don’t work very well. Some lack a seamless view that can show the relatedness of model concepts that run between the two implementation environments. One common outcome is an application fractured in two: a static data storage system using objects, and an ad hoc rules processing application that has lost almost all connection with the object model.

> 但人们并不总是能够从规则引擎的使用中得到预期结果。有些产品并不能很好地工作。有些则缺少一种能够显示出衔接两种实现环境的模型概念相关性的无缝视图。一个常见的结果是应用程序被割裂成两部分：一个是使用了对象的静态数据存储系统，另一个是几乎完全与对象模型失去联系的某种规则处理应用程序。

It is important to continue to think in terms of models while working with rules. The team has to find a single model that can work with both implementation paradigms. This is not easy, but it should be possible if the rules engine allows expressive implementation. Otherwise, the data and the rules become unconnected. The rules in the engine end up more like little programs than conceptual rules in the domain model. With tight, clear relationships between the rules and the objects, the meaning of both pieces is retained.

> 重要的是在使用规则的同时要继续考虑模型。团队必须找到能够同时适用于两种实现范式的单一模型。虽然这并非易事，但还是可以办到的，条件是规则引擎支持富有表达力的实现方式。如果不这样，数据和规则就会失去联系。与领域模型中的概念规则相比，引擎中的规则更像是一些较小的程序。只有保持规则与对象之间紧密、清晰的关系，才能确保显示出这二者所表达的含义。

Without a seamless environment, it falls on the developers to distill a model made up of clear, fundamental concepts to hold the whole design together.

> 如果没有无缝的环境，就要完全靠开发人员提炼出一个由清晰的基本概念组成的模型，以便完全支撑整个设计。

The most effective tool for holding the parts together is a robust UBIQUITOUS LANGUAGE that underlies the whole heterogeneous model. Consistently applying names in the two environments and exercising those names in the UBIQUITOUS LANGUAGE can help bridge the gap.

> 将各个部分紧密结合在一起的最有效工具就是健壮的UBIQUITOUS LANGUAGE，它是构成整个异构模型的基础。坚持在两种环境中使用一致的名称，坚持用UBIQUITOUS LANGUAGE讨论这些名称，将有助于消除两种环境之间的鸿沟。

This is a topic that deserves a book of its own. The goal of this section is merely to show that it isn’t necessary to give up MODEL-DRIVEN DESIGN, and that it is worth the effort to keep it.

> 这个话题本身就值得写一本书了。本节的目的只是想说明（在使用其他范式时）没有必要放弃MODEL-DRIVEN DESIGN，而且坚持使用它是值得的。

Although a MODEL-DRIVEN DESIGN does not have to be object oriented, it does depend on having an expressive implementation of the model constructs, be they objects, rules, or workflows. If the available tool does not facilitate that expressiveness, reconsider the choice of tools. An unexpressive implementation negates the advantage of the extra paradigm.

> 虽然MODEL-DRIVEN DESIGN不一定是面向对象的，但它确实需要一种富有表达力的模型结构实现，无论是对象、规则还是工作流，都是如此。如果可用工具无法提高表达力，就要重新考虑选择工具。缺乏表达力的实现将削弱各种范式的优势。

Here are four rules of thumb for mixing nonobject elements into a predominantly object-oriented system:

> 当将非对象元素混合到以面向对象为主的系统中时，需要遵循以下4条经验规则。

- Don’t fight the implementation paradigm. There’s always another way to think about a domain. Find model concepts that fit the paradigm.
- Lean on the ubiquitous language. Even when there is no rigorous connection between tools, very consistent use of language can keep parts of the design from diverging.
- Don’t get hung up on UML. Sometimes the fixation on a tool, such as UML diagramming, leads people to distort the model to make it fit what can easily be drawn. For example, UML does have some features for representing constraints, but they are not always sufficient. Some other style of drawing (perhaps conventional for the other paradigm), or simple English descriptions, are better than tortuous adaptation of a drawing style intended for a certain view of objects.
- Be skeptical. Is the tool really pulling its weight? Just because you have some rules, that doesn’t necessarily mean you need the overhead of a rules engine. Rules can be expressed as objects, perhaps a little less neatly; multiple paradigms complicate matters enormously.

---


> - 不要和实现范式对抗。我们总是可以用别的方式来考虑领域。找到适合于范式的模型概念。
> - 把通用语言作为依靠的基础。即使工具之间没有严格联系时，语言使用上的高度一致性也能防止各个设计部分分裂。
> - 不要一味依赖UML。有时固定使用某种工具（如UML绘图工具）将导致人们通过歪曲模型来使它更容易画出来。例如，UML确实有一些特性很适合表达约束，但它并不是在所有情况下都适用。有时使用其他风格的图形（可能适用于其他范式）或者简单的语言描述比牵强附会地适应某种对象视图更好。
> - 保持怀疑态度。工具是否真正有用武之地？不能因为存在一些规则，就必须使用规则引擎。规则也可以表示为对象，虽然可能不是特别优雅。多个范式会使问题变得非常复杂。

Before taking on the burden of mixed paradigms, the options within the dominant paradigm should be exhausted. Even though some domain concepts don’t present themselves as obvious objects, they often can be modeled within the paradigm. Chapter 9 will discuss the modeling of unconventional types of concepts using object technology.


> 在决定使用混合范式之前，一定要确信主要范式中的各种可能性都已经尝试过了。尽管有些领域概念不是以明显的对象形式表现出来的，但它们通常可以用对象范式来建模。第9章将讨论如何使用对象技术对一些非常规类型的概念进行建模。

The relational paradigm is a special case of paradigm mixing. The most common nonobject technology, the relational database is also more intimately related to the object model than other components, because it acts as the persistent store of the data that makes up the objects themselves. Storing object data in relational databases will be discussed in Chapter 6, along with the many other challenges of the object life cycle.

> 关系范式是范式混合的一个特例。作为一种最常用的非对象技术，关系数据库与对象模型的关系比其他技术与对象模型的关系更紧密，因为它作为一种数据持久存储机制，存储的就是对象。第6章将讨论用关系数据库来存储对象数据，并介绍在对象生命周期中将会遇到的诸多挑战。