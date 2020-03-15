# 第 9 章 将隐式概念转变为显式概念

> Nine. Making Implicit Concepts Explicit

Deep modeling sounds great, but how do you actually do it? A deep model has power because it contains the central concepts and abstractions that can succinctly and flexibly express essential knowledge of the users’ activities, their problems, and their solutions. The first step is to somehow represent the essential concepts of the domain in the model. Refinement comes later, after successive iterations of knowledge crunching and refactoring. But this process really gets into gear when an important concept is recognized and made explicit in the model and design.

> 深层建模听起来很不错，但是我们要如何实现它呢？深层模型之所以强大是因为它包含了领域的核心概念和抽象，能够以简单灵活的方式表达出基本的用户活动、问题以及解决方案。深层建模的第一步就是要设法在模型中表达出领域的基本概念。随后，在不断消化知识和重构的过程中，实现模型的精化。但是实际上这个过程是从我们识别出某个重要概念并且在模型和设计中把它显式地表达出来的那个时刻开始的。

Many transformations of domain models and the corresponding code happen when developers recognize a concept that has been hinted at in discussion or present implicitly in the design, and they then represent it explicitly in the model with one or more objects or relationships.

> 若开发人员识别出设计中隐含的某个概念或是在讨论中受到启发而发现一个概念时，就会对领域模型和相应的代码进行许多转换，在模型中加入一个或多个对象或关系，从而将此概念显式地表达出来。

Occasionally, this transformation of a formerly implicit concept into an explicit one is a breakthrough that leads to a deep model. More often, though, the breakthrough comes later, after a number of important concepts are explicit in the model; after successive refactorings have tweaked their responsibilities repeatedly, changed their relationships with other objects, and even changed their names a few times. Everything finally snaps into focus. But the process starts with recognizing the implied concepts in some form, however crude.

> 有时，这种从隐式概念到显式概念的转换可能是一次突破，使我们得到一个深层模型。但更多的时候，突破不会马上到来，而需要我们在模型中显式表达出许多重要概念，并通过一系列重构不断地调整对象职责、改变它们与其他对象的关系、甚至多次修改对象名称，在这之后，突破才会姗姗而来。最后，所有事情都变得清晰了。但是要实现上述过程，必须首先识别出以某种形式存在的隐含概念，无论这些概念有多么原始。

## 9.1 DIGGING OUT CONCEPTS 概念挖掘

Developers have to sensitize themselves to the hints that reveal lurking implicit concepts, and sometimes they have to proactively search them out. Most such discoveries come from listening to the language of the team, scrutinizing awkwardness in the design and seeming contradictions in the statements of experts, mining the literature of the domain, and doing lots and lots of experimentation.

> 开发人员必须能够敏锐地捕捉到隐含概念的蛛丝马迹，但有时他们必须主动寻找线索。要挖掘出大部分的隐含概念，需要开发人员去倾听团队语言、仔细检查设计中的不足之处以及与专家观点相矛盾的地方、研究领域相关文献并且进行大量的实验。

### 9.1.1 Listen to Language 倾听语言

You may remember an experience like this: The users have always talked about some item on a report. The item is compiled from attributes of various objects and maybe even a direct database query. The same data set is assembled in another part of the application in order to present or report or derive something. But you have never seen the need for an object. Probably, you have never really understood what the users meant by a particular term and had not realized it was important.

> 你可能会想起这样的经历：用户总是不停地谈论报告中的某一项。该项可能来自各种对象的参数汇编，甚至还可能来自一次直接的数据库查询。同时，应用程序的另一部分也需要这个数据集来进行显示、报告或其他操作。但是，你却一直认为没有必要为此创建一个对象。也许你一直没有真正理解用户想通过某个特定术语传达的东西，也没有意识到它的重要性。

Then suddenly a light comes on in your head. The name of the item on that report designates an important domain concept. You talk excitedly with your experts about your new insight. Maybe they show relief that you finally got it. Maybe they yawn because they’ve taken it for granted all along. Either way, you start to draw model diagrams on the board that fill in for some hand waving that you’ve always done before. The users correct you on the details of how the new model connects, but you can tell that there is a change in the quality of the discussion. You and the users understand each other more precisely, and demonstrations of model interactions to solve specific scenarios have become more natural. The language of the domain model has become more powerful. You refactor the code to reflect the new model and find you have a cleaner design.

> 然后，你突然灵机一动。原来，报告中该项名称给出了一个重要的领域概念。你高兴地与专家谈起了这个新发现。他们可能会松一口气，因为你终于明白了。也可能会觉得很平常，因为他们一直认为这是理所当然的。不管专家们如何反应，你开始在白板上画模型图了（之前你也一直这么做）。用户会帮助你修正新模型连接方面的细节，但你明显感到讨论的质量有所提高。你和用户可以更加准确地理解对方，并且可以更加自然地用模型交互来演示特定场景。领域模型的语言也变得更加强大。然后，你可以重构代码来反映新模型，同时也会发现你的设计变得更加清晰了。

Listen to the language the domain experts use. Are there terms that succinctly state something complicated? Are they correcting your word choice (perhaps diplomatically)? Do the puzzled looks on their faces go away when you use a particular phrase? These are hints of a concept that might benefit the model.

> 倾听领域专家使用的语言。有没有一些术语能够简洁地表达出复杂的概念？他们有没有纠正过你的用词（也许是很委婉的提醒）？当你使用某个特定词语时，他们脸上是否已经不再流露出迷惑的表情？这些都暗示了某个概念也许可以改进模型。

This is not the old “nouns are objects” notion. Hearing a new word produces a lead, which you follow up with conversation and knowledge crunching, with the goal of carving out a clean, useful concept. When the users or domain experts use vocabulary that is nowhere in the design, that is a warning sign. It is a doubly strong warning when both the developers and the domain experts are using terms that are not in the design.

> 这不同于原来的“名词即对象”概念。听到新单词只是个开头，然后我们还要进行对话、消化知识，这样才能挖掘出清晰实用的概念。如果用户或领域专家使用了设计中没有的词汇，这就是个警告信号。而当开发人员和领域专家都在使用设计中没有的词汇时，那就是一个倍加严重的警告信号了。

Or perhaps it is better to look at it as an opportunity. The UBIQUITOUS LANGUAGE is made up of the vocabulary that pervades speech, documents, model diagrams, and even code. If a term is absent from the design, it is an opportunity to improve the model and design by including it.

> 或者，应该把这种警告看成一次机会。UBIQUITOUS LANGUAGE 是由遍布于对话、文档、模型图甚至代码中的词汇构成的。如果出现了设计中没有的术语，就可以把它添加到通用语言中，这样也就有机会改进模型和设计了。

Example: Hearing a Missing Concept in the Shipping Model

> 示例听出运输模型中缺失的一个概念

The team had already developed a working application that could book a cargo. They were starting to build an “operations support” application that would help juggle the work orders for loading and unloading cargos at the origin and destination and at transfers between ships.

> 团队已经开发出了可用来预订货物的有效应用程序。现在他们开始开发“作业支持”应用程序，此程序可帮助工作人员管理工作单，这些工作单用于安排起始地和目的地的货物装卸以及在不同货轮之间转运时需要的货物装卸。

The booking application used a routing engine to plan the trip for a cargo. Each leg of the journey was stored in a row of a database table, indicating the ID of the vessel voyage (a particular voyage by a particular ship) slated to carry the cargo, the location where it would be loaded, and the location where it would be unloaded.

> 预定应用程序使用一个路线引擎来安排货物行程。运输过程的每段行程都作为一行数据存储在数据库表中，其中指定了装载该货物的船名航次（某一货轮的某一航次）ID、装货地点以及卸货地点，如图 9-1 所示。

<Figures figure="9-1"></Figures>

- Let’s eavesdrop on a conversation (heavily abbreviated) between the developer and a shipping expert.
- Developer: I want to make sure the “cargo bookings” table has all the data that the operations application will need.
- Expert: They’re going to need the whole itinerary for the Cargo. What information does it have now?
- Developer: The cargo ID, the vessel voyage, the loading port, and the unloading port for each leg.
- Expert: What about the date? Operations will need to contract handling work based on the expected times.
- Developer: Well, that can be derived from the schedule of the vessel voyage. The table data is normalized.
- Expert: Yes, it is normal to need the date. Operations people use these kinds of itineraries to plan for upcoming handling work.
- Developer: Yeah . . . OK, they’ll definitely have access to the dates. The operations management application will be able to provide the whole loading and unloading - sequence, with the date of each handling operation. The “itinerary,” I guess you would say.
- Expert: Good. The itinerary is the main thing they’ll need. Actually, you know, the booking application has a menu item that will print an itinerary or e-mail it to - the customer. Can you use that somehow?
- Developer: That’s just a report, I think. We won’t be able to base the operations application on that.
- [Developer looks thoughtful, then excited.]
- Developer: So, this itinerary is really the link between booking and operations.
- Expert: Yes, and some customer relations, too.
- Developer: [Sketching a diagram on the whiteboard.] So would you say it is something like this?

---

> - 开发人员：我想要确认一下 cargo bookings（货物预订）表中是否已包含了作业应用程序所需的全部数据。
> - 专家：他们需要 Cargo 的全部航海日程（Itinerary）。现在表中有哪些信息？
> - 开发人员：货物 ID、船名航次以及每个航段的装货港口和卸货港口。
> - 专家：那么日期呢？需要按照预计的时间来进行装卸工作。
> - 开发人员：嗯，日期可以从船名航次安排中获得。该表的数据已经得到了规范化处理。
> - 专家：是的，日期通常都是必需的数据。作业人员会用这类航海日程来安排后面的装卸工作。
> - 开发人员：嗯……好的。他们肯定可以得到日期数据。作业管理应用程序可以提供全部装货和卸货信息以及每次装卸作业的日期。我猜这也就是你所说的“航海日程”。
> - 专家：很好。航海日程是他们需要的主要数据。事实上，你知道，预订应用程序包含了一个菜单项，可以打印出航海日程或将航海日程通过电子邮件发送给顾客。你能想办法利用这个功能吗？
> - 开发人员：我想那只是个报表。我们无法据此来开发作业应用程序。
> - [开发人员陷入了沉思，然后开始兴奋起来。]
> - 开发人员：那么，航海日程实际上把预订程序和作业程序连接起来了。
> - 专家：是的。它同时还连接了一些客户关系。
> - 开发人员：[在白板上画出了一个草图。]那么，你觉得是这样的吗？

<Figures figure="9-2"></Figures>

- Expert: Yes, that looks basically right. For each leg you’d like to see the vessel voyage, the load and unload location, and time.
- Developer: So once we create the Leg object, it can derive the times from the vessel voyage schedule. We can make the Itinerary object our main point of contact with the operations application. And we can rewrite that itinerary report to use this, so we’ll get the domain logic back into the domain layer.
- Expert: I didn’t follow all of that, but you are right that the two main uses for the Itinerary are in the report in booking and in the operations application.
- Developer: Hey! We can make the Routing Service interface return an itinerary object instead of putting the data in the database table. That way the routing engine doesn’t need to know about our tables.
- Expert: Huh?
- Developer: I mean, I’ll make the routing engine just return an Itinerary. Then it can be saved in the database by the booking application when the rest of the booking is saved.
- Expert: You mean it isn’t that way now?!

---

> - 专家：是的，基本上是这样。在每段行程中，我们都希望看到船名航次、装货和卸货地点以及时间。
> - 开发人员：所以，我们一旦创建了 Leg（般段）对象，就能够从航次安排中获取时间信息。我们可以将 Itinerary（航海日程）对象作为与作业应用程序联系的主要连接点。同时，还可以用这种方式重新编写航海日程报表，这样领域逻辑就重新回到领域层中了。
> - 专家：有些地方我不太明白，但是你说对了 Itinerary 的两个主要用途，一是用在预订应用程序报表功能中，二是用在作业应用程序中。
> - 开发人员：嘿！我们可以让 Routing Service（路线服务）接口返回航程对象，而不用将数据写入数据库表。这样一来，路线引擎就不需要知道数据库表了。
> - 专家：嗯？
> - 开发人员：我是说，我可以让路线引擎只返回一个 Itinerary。然后，预订应用程序在保存剩下的信息时把它一起存储到数据库中。
> - 专家：你是说现在的程序并没有这么做吗？！

The developer then went off to talk with the other developers involved in the routing process. They hashed out the changes to the model and the implications for the design, calling on the shipping experts when needed. They came up with the diagram in Figure 9.3.

> 这位开发人员回去与负责路线处理的人员进行讨论。他们仔细研究了这会给模型和设计带来什么影响和变化，在必要的时候也去请教了运输专家。最后，他们得到了图 9-3 所示的模型。

<Figures figure="9-3"></Figures>

Next, the developers refactored the code to reflect the new model. They did it in a series of two or three refactorings, but in quick succession, within a week, except for simplifying the itinerary report in the booking application, which they took care of early the following week.

> 接下来，开发人员对代码进行了重构，以使它能反映出新的模型。在一周内，他们很快对代码作出了一系列的修改，每次修改都进行两到三次重构。但是他们还没有对预订应用程序中的航海日程报告进行简化，而简化工作将会在接下来的一周开始进行。

The developer had been listening closely enough to the shipping expert to notice how important the concept of an “itinerary” was to him. True, all the data was already being collected, and the behavior was implicit in the itinerary report, but the explicit Itinerary as part of the model opened up opportunities.

> 这位开发人员一直都在仔细倾听运输专家的见解，并注意到“航海日程”概念的重要性。事实上，所有的数据都已收集，在航海日程报告中也已隐含了操作行为，但是，把显式的 Itinerary 对象作为模型的一部分给他们带来了新的机会。

Benefits of refactoring to the explicit Itinerary object:

> 通过重构得到显式的 Itinerary 对象的益处是：

1. Defining the interface of the Routing Service more expressively
2. Decoupling the Routing Service from the booking database tables
3. Clarifying the relationship between the booking application and the operations support application (the sharing of the Itinerary object)
4. Reducing duplication, because the Itinerary derives loading/unloading times for both the booking report and the operations support application
5. Removing domain logic from the booking report and placing it in the isolated domain layer
6. Expanding the UBIQUITOUS LANGUAGE, allowing a more precise discussion of the model and design between developers and domain experts and among the developers themselves

---

> 1. 更明确地定义 Routing Service 接口；
> 2. 将 Routing Service 与预订数据库表解耦——Routing Service 无需关心存储逻辑；
> 3. 明确了预订应用程序和作业支持应用程序之间的关系（即共享 Itinerary 对象）；
> 4. 减少重复，因为 Itinerary 可同时为预订报表和作业支持应用程序提供装货/卸货时间；
> 5. 从预订报表中删除领域逻辑，并将其移至独立的领域层；
> 6. 扩充了 UBIQUITOUS LANGUAGE，使得开发人员和领域专家之间或者开发人员内部能够更准确地讨论模型和设计。

### 9.1.2 Scrutinize Awkwardness 检查不足之处

The concept you need is not always floating on the surface, emerging in conversation or documents. You may have to dig and invent. The place to dig is the most awkward part of your design. The place where procedures are doing complicated things that are hard to explain. The place where every new requirement seems to add complexity.

> 你所需要的概念并不总是浮在表面上，也绝不仅仅是通过对话和文档就能让它显现出来。有些概念可能需要你自己去挖掘和创造。要挖掘的地方就是设计中最不足的地方，也就是操作复杂且难于解释的地方。每当有新的需求时，似乎都会让这个地方变得更加复杂。

Sometimes it can be hard to recognize that there even is a missing concept. You may have objects doing all the work but find some of the responsibilities awkward. Or, if you do realize something is missing, a model solution may elude you.

> 有时，你很难意识到模型中丢失了什么概念。也许你的对象能够实现所有的功能，但是有些职责的实现却很笨拙。而有时，你虽然能够意识到模型中丢失了某些东西，但是却无法找到解决方案。

Now you have to actively engage the domain experts in the search. If you are lucky, they may enjoy playing with ideas and experimenting with the model. If you are not that lucky, you and your fellow developers will have to come up with the ideas, using the domain expert as a validator, watching for discomfort or recognition on his or her face.

> 这个时候，你必须积极地让领域专家参与到讨论中来。如果你足够幸运，这些专家可能会愿意一起思考各种想法，并通过模型来进行验证。如果你没那么幸运，你和你的同事就不得不自己思索出不同的想法，让领域专家对这些想法进行判断，并注意观察专家的表情是认同还是反对。

Example: Earning Interest the Hard Way

> 示例摸索利息计算模型

The next story is set in a hypothetical financial company that invests in commercial loans and other interest-bearing assets. An application that tracks those investments and the earnings from them has been evolving incrementally, feature by feature. Each night, one component was to run as a batch script, calculating all interest and fees for the day and then recording them appropriately in the company’s accounting software.

> 下面的故事以一家假想的金融公司为背景，该公司经营商业贷款和其他一些生息资产。公司开发了一个用于跟踪这些投资及收益的应用程序，通过一项一项地添加功能来使它不断地发展。每天晚上，公司都会运行一个批处理脚本，用于计算当天所生成的利息和费用，并把它们相应地记录到公司的财务软件中。

<Figures figure="9-4">An awkward model</Figures>

The nightly batch script iterated through each Asset, telling each to calculateInterestForDate() on that day’s date. The script took the return value (the amount earned) and passed this amount, along with the name of a specific ledger, to a SERVICE that provided the public interface of the accounting program. That software posted the amount to the named ledger. The script went through a similar process to get the day’s fees from each Asset, posting them to a different ledger.

> 晚间批处理脚本会遍历每笔 Asset（资产），并让其执行 `calculateInterestForDate()`，按照当天的日期来计算利息。然后，该脚本会接收返回值（收益金额），并将它和指定分类账的名称一起发送给一个 SERVICE（这个 SERVICE 提供了记账程序的公共接口）。再由记账软件将收入金额过账到指定的分类账中。这个脚本还会对每笔 Asset 当日的手续费作类似的处理，并记录到另一个不同的分类账中。

A developer had been struggling with the increasing complexity of calculating interest. She started to suspect an opportunity for a model better suited to the task. This developer asked her favorite domain expert to help her dig into the problem area.

> 负责这个程序的一位开发人员一直在费力地应对日益复杂的利息计算。她开始怀疑应该能找到一个更适合完成此项任务的模型。于是，她向她熟识的领域专家寻求帮助，希望专家可以协助她深入研究这个问题。

- Developer: Our Interest Calculator is getting out of hand.
- Expert: That is a complicated part. We still have more cases we’ve been holding back.
- Developer: I know. We can add new interest types by substituting a different Interest Calculator. But what we’re having the most trouble with right now is all these special cases when they don’t pay the interest on schedule.
- Expert: Those really aren’t special cases. There’s a lot of flexibility in when people pay.
- Developer: Back when we factored out the Interest Calculator from the Asset, it helped a lot. We may need to break it up more.
- Expert: OK.
- Developer: I was thinking you might have a way of talking about this interest calculation.
- Expert: What do you mean?
- Developer: Well, for example, we’re tracking the interest due but unpaid within an accounting period. Do you have a name for that?
- Expert: Well, we don’t really do it like that. The interest earned and the payment are quite separate postings.
- Developer: So you don’t need that number?
- Expert: Well, sometimes we might look at it, but it isn’t the way we do business.
- Developer: OK, so if the payment and interest are separate, maybe we should model them that way. How does this look? [Sketching on whiteboard]

---

> - 开发人员：我们的 Interest Calculator（利息计算器）太复杂了。
> - 专家：这一部分确实很复杂。还有很多情况我们都推迟考虑了。
> - 开发人员：我知道。我们可以使用另一个不同的 Interest Calculator 来添加新的利息类型。但现在最大的麻烦是，如果没有按时支付利息，该如何去处理由此引发的各种特殊情况。
> - 专家：其实这些不算是特殊情况。人们支付利息的方式可以非常灵活。
> - 开发人员：记得之前我们重构 Asset，将 Interest Calculator 从中分离出来，这对开发工作大有帮助。我们可能还需要进一步分解 Asset。
> - 专家：没问题。
> - 开发人员：我在想你们在讨论这种利息计算时可能有另外的方式。
> - 专家：你指的是什么？
> - 开发人员：举个例子，假设我们正在跟踪会计期（accounting period）内到期的未付利息。这种利息有名字吗？
> - 专家：哦，实际上我们并不会这么做。利息收入和付款是完全独立的过账。
> - 开发人员：所以你们不需要这个数字（到期的未付利息）？
> - 专家：有时我们也许会看看，但这不是我们处理业务的方式。
> - 开发人员：好吧。如果付款和利息是彼此独立的，也许我们应该这样建模。这看起来怎么样？[在白板上画出草图。]

<Figures figure="9-5"></Figures>

- Expert: It makes sense, I guess. But you just moved it from one place to another.
- Developer: Except now the Interest Calculator only keeps track of interest earned, and the Payment keeps that number separately. It hasn’t simplified it a lot, but does it better reflect your business practice?
- Expert: Ah. I see. Could we have interest history, too? Like the Payment History.
- Developer: Yes, that has been requested as a new feature. But that could have been added onto the original design.
- Expert: Oh. Well, when I saw interest and Payment History separated like that, I thought you were breaking up the interest to organize it more like the Payment History. Do you know anything about accrual basis accounting?
- Developer: Please explain.
- Expert: Each day, or whenever the schedule calls for, we have an interest accrual that gets posted to a ledger. The payments are posted a different way. This aggregate you have here is a little awkward.
- Developer: You’re saying that if we keep a list of “accruals,” they could be aggregated or . . . “posted” as needed.
- Expert: Probably posted on the accrual date, but yes, aggregated anytime. Fees work the same way, posted to a different ledger, of course.
- Developer: Actually, the interest calculation would be simpler if it was done just for one day, or period. And then we could just hang on to them all. How about this?

---

> - 专家：我想这是合乎情理的。但你只是把它从一个地方移到了另一个地方。
> - 开发人员：不过现在 Interest Calculator 只负责追踪利息收入了，付款的数目则是由 Payment 单独管理。这个模型并没有简化什么，但它是不是能够更好地反映出业务惯例呢？
> - 专家：啊。我懂了。我们能够同时保留利息的历史记录吗？就像之前模型中的 PaymentHistory（付款历史）一样。
> - 开发人员：可以。这已经被作为一项新功能提出来了。但是，它本来应该在初始设计中就加进来。
> - 专家：哦。是这样，我看到你以这种方式分离利息和 Payment History，还以为你们要把利息分解并组织成类似于 Payment History 的结构。你对应计制会计（accrual basis accounting）有所了解吗？
> - 开发人员：请解释一下。
> - 专家：我们每天（或根据计划安排）都会把应计利息过账到收支总账中。而支付的过账方法则完全不同。你在这里把应计利息累加起来有点不大合适。
> - 开发人员：你是说，如果我们保留“应计利息”列表，那么这些利息就可以根据需要来进计算总计或者……“过账”。
> - 专家：应该是在应计日期过账，但是可以在任意时间内累加。费用的处理与此相同，当然，是要提交到另一个分类账中。
> - 开发人员：事实上，如果只计算一天或一段时间的利息，问题就会简单得多。然后，我们就能够解决所有这些问题了。这看起来怎么样？

<Figures figure="9-6"></Figures>

- Expert: Sure. It looks good. I’m not sure why this would be easier for you. But basically, what makes any asset valuable is what it can accrue in interest, fees, and so on.
- Developer: You said fees work the same way? They . . . what was it . . . post to different ledgers?

---

> - 专家：不错。这看起来很好。我不明白为什么这对你来说会简单得多。但基本上，资产之所以有价值，就是因为通过它可以累积利息、费用等。
> - 开发人员：你是说手续费也是一样的吗？它们……怎么说来着？……要过账到不同的分类账中？

<Figures figure="9-7"></Figures>

- Developer: With this model, we get the interest calculation, or rather, the accrual calculation logic that was in the Interest Calculator separated from tracking. And I hadn’t noticed until now how much duplication there is in the Fee Calculator. Also, now the different kinds of fees can easily be added.
- Expert: Yes, the calculation was correct before, but I can see everything now.

---

> - 开发人员：在这个模型中，我们将 Interest Calculator 中的利息计算（或者说是应计费用的计算逻辑）与跟踪利息的功能分开了。直到现在我才注意到 Fee Calculator 与 Interest Calculator 有很多重复的地方。此外，现在不同类型的费用也可以轻松地添加进来了。
> - 专家：是的。之前的计算也是正确的，但现在变得一目了然了。

Because the Calculator classes hadn’t been directly coupled with other parts of the design, this was a fairly easy refactoring. The developer was able to rewrite the unit tests to use the new language in a few hours and had the new design working late the next day. She ended up with this.

> 由于 Calculator 类并没有直接与设计中的其他部分相关联，所以这其实是一个非常简单的重构。这位开发人员只需花几个小时就能够通过重写单元测试来验证新的语言，第二天新的设计就可以用了。最终，她得到了下面的模型。

<Figures figure="9-8">A deeper model after refactoring</Figures>

In the refactored application, the nightly batch script tells each Asset to calculateAccrualsThroughDate(). The return value is a collection of Accruals, each of whose amounts it posts to the indicated ledger.

> 在重构后的应用程序中，夜间批处理脚本会通知每个 Asset 执行 `calculateAccrualsThroughDate()`。其返回值是 Accrual 的集合，而其中的每笔金额都会过账到指定的分类账中。

The new model has several advantages. The change

> 新模型具有几个优点，包括：

1. Enriches the UBIQUITOUS LANGUAGE with the term “accrual”
2. Decouples accrual from payment
3. Moves domain knowledge (such as which ledger to post to) from the script and into the domain layer
4. Brings fees and interest together in a way that fits the business and eliminates duplication in the code
5. Provides a straightforward path for adding new variations of fees and interest as Accrual Schedules

---

> 1. 术语“应计费用（accrual）”使 UBIQUITOUS LANGUAGE 更丰富；
> 2. 将应计费用从付款中分离出来；
> 3. 将领域知识（如过账到哪个分类账）从脚本中移出来，并放到领域层中；
> 4. 将费用与利息统一，既能够符合业务逻辑，又可消除重复代码；
> 5. 新形式的费用和利息可以通过 Accrual Schedule 直接添加到模型中。

This time, the developer had to dig for the new concepts she needed. She could see the awkwardness of the interest calculations and made a committed effort to look for a deeper answer.

> 这一次，开发人员不得不自己挖掘所需的新概念。她能够看出利息计算的不足之处，并坚持不懈地寻找更深层次的解决方案。

She was lucky to have an intelligent and motivated partner in the banking expert. With a more passive source of expertise, she would have made more false starts and depended more on other developers as brainstorming partners. Progress would have been slower, but still possible.

> 她很幸运地找到一位聪明且热忱的银行专家作为合作伙伴。如果合作的专家不那么主动的话，她可能会在初期犯更多的错误，而后则需要更多地依赖与其他开发人员进行头脑风暴来解决问题。这样，程序开发的进度会放慢，但还是有可能获得进展。

### 9.1.3 Contemplate Contradictions 思考矛盾之处

Different domain experts see things different ways based on their experience and needs. Even the same person provides information that is logically inconsistent after careful analysis. Such pesky contradictions, which we encounter all the time when digging into program requirements, can be great clues to deeper models. Some are just variations in terminology or are based on misunderstanding. But there is a residue where two factual statements by experts seem to contradict.

> 由于经验和需求的不同，不同的领域专家对同样的事情会有不同的看法。即使是同一个人提供的信息，仔细分析后也会发现逻辑上不一致的地方。在挖掘程序需求的时候，我们会不断遇到这种令人烦恼的矛盾，但它们也为深层模型的实现提供了重要线索。有些矛盾只是术语说法上的不一致，有些则是由于误解而产生的。但还有一种情况是专家们会给出相互矛盾的两种说法。

The astronomer Galileo once posed a paradox. The evidence of the senses clearly indicates that the Earth is stationary: people are not being blown off and falling behind. Yet Copernicus had made a compelling argument that the Earth was moving around the sun quite rapidly. Reconciling this might reveal something profound about how nature works.

> 天文学家伽利略曾提出过一个悖论。我们的感觉清楚地表明地球是静止的：人们既不会被吹走也不会被抛出去。然而哥白尼提出了一个很有说服力的观点，即地球是围绕着太阳飞速转动的。将这一矛盾统一起来可能会揭示出大自然运转的某种深奥的规律。

Galileo devised a thought experiment. If a rider dropped a ball from a running horse, where would it fall? Of course, the ball would move along with the horse until it hit the ground by the horse’s feet, just as if the horse were standing still. From this he deduced an early form of the idea of inertial frames of reference, solving the paradox and leading to a much more useful model of the physics of motion.

> 于是，伽利略设计了一个假想实验。如果一个骑手在奔跑的马背上丢下一个球，这个球会掉到哪里？显然，这个球会随着马一起向前移动，直到它落在马蹄旁边的地面上，就像马一直站着没动时一样。根据这个实验，伽利略推导出了惯性参考系思想的早期雏形，它可以解决前面提到的悖论并可引出更为实用的物理运动模型。

OK. Our contradictions are usually not so interesting, nor the implications so profound. Even so, this same pattern of thought often helps pierce the superficial layers of a problem domain into a deeper insight.

> 我们遇到的矛盾通常不会这么有趣，也不会具有如此深刻的意义。尽管如此，采用同样的思考模式通常可以帮助我们透过问题领域的表面获得更深层的理解。

It is not practical to reconcile all contradictions, and it may not even be desirable. (Chapter 14 delves into how to decide and how to manage the result.) However, even when a contradiction is left in place, contemplation of how two statements could both apply to the same external reality can be revealing.

> 要解决所有矛盾是不太现实的，甚至是不需要的。（第 14 章将会深入探讨如何取舍以及如何处理结果。）然而，即使不去解决矛盾，我们也应该仔细思考对立的两种看法是如何同时应用于同一个外部现实的，这会给我们带来启示。

### 9.1.4 Read the Book 查阅书籍

Don’t overlook the obvious when seeking model concepts. In many fields, you can find books that explain the fundamental concepts and conventional wisdom. You still have to work with your own domain experts to distill the part relevant to your problem and to crunch it into something suited to object-oriented software. But you may be able to start with a coherent, deeply considered view.

> 在寻找模型概念时，不要忽略一些显而易见的资源。在很多领域中，你都可以找到解释基本概念和传统思想的书籍。你依然需要与领域专家合作，提炼与你的问题相关的那部分知识，然后将其转化为适用于面向对象软件的概念。但是，查阅书籍也许能够使你一开始就形成一致且深层的认识。

Example: Earning Interest by the Book

> 示例借助参考书来设计利息计算模型

Let’s imagine a different scenario for the investment-tracking application discussed in the previous example. Just as before, the story starts with the developer realizing that the design is getting unwieldy, particularly the Interest Calculator. But in this scenario, the domain expert’s primary responsibilities lie elsewhere, and he doesn’t have much interest in helping the software development project. In this scenario, the developer couldn’t turn to the expert for a brainstorming session to probe for the missing concepts she suspected to be lurking under the surface.

> 让我们设想一下前面讨论的投资跟踪应用程序的另一个场景。与前面一样，这个故事的开头也是开发人员意识到设计变得越来越笨拙，特别是 Interest Calculator。但是在这个场景中，领域专家主要负责其他工作，他对帮助软件开发项目并不十分感兴趣。在这里，开发人员不能指望专家与其一起进行头脑风暴，帮助她探寻隐藏于表象之下的遗漏概念。

Instead, she went to the bookstore. After a little browsing, she found an introductory accounting book she liked, and she skimmed it. She discovered a whole system of well-defined concepts. An excerpt that particularly fired her thinking:

> 于是，她去了书店。随意翻阅了几本书之后，她找到了一本自己比较喜欢的会计学入门书籍，并把它粗略浏览了一遍。她发现书中有一整套明确定义的概念体系。其中一段文字给了她特别大的启发：

Accrual Basis Accounting. This method recognizes income when it is earned, even if it is not paid. All expenses also show when they are incurred whether they have been paid for or billed to be paid at a later date. Any obligation due, including taxes, will be shown as expense.

—Finance and Accounting: How to Keep Your Books and Manage Your Finances Without an MBA, a CPA or a Ph.D., by Suzanne Caplan (Adams Media, 2000)

> 应计制会计。这种方法把所有已经产生的收入均计到收入中（即使尚未支付），所有支出也均在产生时显示出来（无论是已经支付还是以后才支付）。所有到期债务，包括税金，都列入费用。
>
> ——Suzanne Caplan 的 Finance and Accounting:How to Keep Your Books andManage Your Finances Without an MBA,a CPA or a Ph.D[Adams Media,2000]

The developer no longer needed to reinvent accounting. After some brainstorming with another developer, she came up with a model.

> 开发人员再也不用自己去重新编造一个会计学出来了。在与其他开发人员进行了一些讨论之后，她设计出了一个模型，如图 9-9 所示。

<Figures figure="9-9">A somewhat deeper model based on book learning</Figures>

She did not have the insight that Assets are income generators, and so the Calculators are still there. The knowledge of ledgers is still in the application, rather than the domain layer where it probably belongs. But she did separate the issue of payment from the accrual of income, which was the most problematic area, and she introduced the word “accrual” into the model and into the UBIQUITOUS LANGUAGE. Further refinement could come with later iterations.

> 她还没有认识到收入是由 Asset 产生的，所以模型中依然含有 Calculator。分类账的概念还是包含在应用程序中，而不是在它本应归属的领域层中。但是，她确实将付款从应计收入中分离出来了（这曾是最大的问题）并且她将“应计费用”这个词引入到模型和 UBIQUITOUS LANGUAGE 中。在之后的迭代过程中，模型还会得到进一步的精化。

When she did finally have the chance to talk with the domain expert, he was quite surprised. It was the first time a programmer had shown a glimmer of interest in what he did. Due to the way his responsibilities were assigned, the expert never engaged with her, sitting down to go over the model, as happened in the previous scenario. However, because this developer’s knowledge allowed her to ask better questions, from then on the expert did listen to her carefully, and he made a special effort to answer her questions promptly.

> 当这位开发人员终于有机会与领域专家讨论时，专家大吃一惊。她是专家遇到的第一个对其工作表现出些许兴趣的程序人员。由于职责分配的原因，专家从未像之前例子那样密切配合过——坐下来与她共同商讨模型问题。但是，这位开发人员从书中获取了知识，这使她能够提出很好的问题，所以自此以后，专家开始认真倾听她的见解，并尽力及时地回答她的问题。

Of course, this is not an either-or proposition. Even with ample support from domain experts, it pays to look at the literature to get a grasp of the theory of the field. Most businesses do not have models refined to the level of accounting or finance, but in many there have been thinkers in the field who have organized and abstracted the common practices of the business.

> 当然，看书与咨询领域专家并不冲突。即便能够从领域专家那里得到充分的支持，花点时间从文献资料中大致了解领域理论也是值得的。虽然许多业务并不会像会计学或金融行业那样具有极其细致的模型，但大多数领域中都有一些擅于思考的人，他们已组织并抽象出了业务的一些通用的惯例。

Yet another option the developer had was to read something written by another software professional with development experience in this domain. For example, Chapter 6 of the book Analysis Patterns: Reusable Object Models (Fowler 1997) would have sent her in quite a different direction, not necessarily better or worse. Such reading would not have provided an off-the-shelf solution. It would have given several new starting points for her own experiments, along with the distilled experience of people who have traveled the territory. She would have been spared reinventing the wheel. Chapter 11, “Applying Analysis Patterns,” will delve further into this option.

> 开发人员还有另一个选择，就是阅读在此领域中有过开发经验的软件专业人员编写的资料。例如，《分析模式》[Fowler 1997]一书的第 6 章可能会为她提供一个完全不同的思考方向——无论这个方向会让开发变得更好还是更糟。阅读书籍并不能提供现成的解决方案，但可以为她提供一些全新的实验起点，以及在这个领域中探索过的人总结出来的经验。这样可以避免开发人员重复设计已有的概念。第 11 章将更深入地探讨这一主题。

### 9.1.5 Try, Try Again 尝试，再尝试

The examples I’ve given don’t convey the amount of trial and error involved. I might follow half a dozen leads in conversation before finding one that seems clear and useful enough to try out in the model. I’ll end up replacing that one at least once later, as additional experience and knowledge crunching serve up better ideas. A modeler/designer cannot afford to get attached to his own ideas.

> 上面的例子并没有显示出不断尝试和出错的次数。在讨论过程中，我可能尝试六七种不同的思路，然后找到一个看起来足够清晰且实用的概念，并在模型中尝试它。后面，随着经验的积累和知识的消化，我们会有更好的想法，最终，这个概念至少会被替换一次。因此，建模人员/设计人员绝对不能固执己见。

All these changes of direction are not just thrashing. Each change embeds deeper insight into the model. Each refactoring leaves the design more supple, easier to change the next time, ready to bend in the places that turn out to need to bend.

> 并不是所有这些方向性的改变都毫无用处。每次改变都会把开发人员更深刻的理解添加到模型中。每次重构都使设计变得更灵活并且为那些可能需要修改的地方做好准备。

There really is no choice, anyway. Experimentation is the way to learn what works and doesn’t. Trying to avoid missteps in design will result in a lower quality result because it will be based on less experience. And it can easily take longer than a series of quick experiments.

> 我们其实别无选择。只有不断尝试才能了解什么有效什么无效。企图避免设计上的失误将会导致开发出来的产品质量低劣，因为没有更多的经验可用来借鉴，同时也会比进行一系列快速实验更加费时。

## 9.2 HOW TO MODEL LESS OBVIOUS KINDS OF CONCEPTS 如何为那些不太明显的概念建模

The object-oriented paradigm leads us to look for and invent certain kinds of concepts. Things, even very abstract ones such as “accruals,” are the meat of most object models, along with the actions those things take. These are the “nouns and verbs” that introductory object-oriented design books talk about. But other important categories of concepts can be made explicit in a model as well.

> 面向对象范式会引导我们去寻找和创造特定类型的概念。所有事物（即使是像“应计费用”这种非常抽象的概念）及其操作行为是大部分对象模型的主要部分。它们就是面向对象设计入门书籍所讲到的“名词和动词”。但是，其他重要类别的概念也可以在模型中显式地表现出来。

I’ll discuss three such categories that were not obvious to me when I started with objects. My designs became sharper with each one of these I learned.

> 下面我将会描述 3 个这样的类别，我在开始接触对象时，对它们的认识并不够清晰。我每学会一个这样的类别，就会让设计变得更加清晰深刻。

### 9.2.1 Explicit Constraints 显式的约束

Constraints make up a particularly important category of model concepts. They often emerge implicitly, and expressing them explicitly can greatly improve a design.

> 约束是模型概念中非常重要的类别。它们通常是隐含的，将它们显式地表现出来可以极大地提高设计质量。

Sometimes constraints find a natural home in an object or method. A “Bucket” object must guarantee the invariant that it does not hold more than its capacity.

> 有时，约束很自然地存在于对象或方法中。Bucket（桶）对象必须满足一个固定规则——内容（contents）不能超出它的容量（capacity），如图 9-10 所示。

<Figures figure="9-10"></Figures>

A simple invariant like this can be enforced using case logic in each operation capable of changing contents.

> 这样一个简单的固定规则可以在每次可改变内容的操作中使用一个逻辑判断来保证。

```java
class Bucket {
   private float capacity;
   private float contents;

   public void pourIn(float addedVolume) {
      if (contents + addedVolume > capacity) {
         contents = capacity;
      } else {
         contents = contents + addedVolume;
      }
   }
}
```

This logic is so simple that the rule is obvious. But you can easily imagine this constraint getting lost in a more complicated class. Let’s factor it into a separate method, with a name that clearly and explicitly expresses the significance of the constraint.

> 这里的逻辑非常简单，规则也很明显。但是不难想象，在更复杂的类中这个约束可能会丢失。让我们把这个约束提取到一个单独的方法中，并用清晰直观的名称来表达它的意义。

```java
class Bucket {
   private float capacity;
   private float contents;
   public void pourIn(float addedVolume) {
      float volumePresent = contents + addedVolume;
      contents = constrainedToCapacity(volumePresent);
   }

   private float constrainedToCapacity(float volumePlacedIn) {
      if (volumePlacedIn > capacity) return capacity;
      return volumePlacedIn;
   }
}
```

Both versions of this code enforce the constraint, but the second has a more obvious relationship to the model (the basic requirement of MODEL-DRIVEN DESIGN). This very simple rule was understandable in its original form, but when the rules being enforced are more complex, they start to overwhelm the object or operation they apply to, as any implicit concept does. Factoring the constraint into its own method allows us to give it an intention-revealing name that makes the constraint explicit in our design. It is now a named thing we can discuss. This approach also gives the constraint room. A more complex rule than this might easily produce a method longer than its caller (the pourIn() method, in this case). This way, the caller stays simple and focused on its task while the constraint can grow in complexity if need be.

> 这两个版本的代码都实施了约束，但是第二个版本与模型的关系更为明显（这也是 MODEL-DRIVEN DESIGN 的基本需求）。这个规则十分简单，使用最初形式的代码也很容易理解，但如果要是执行的规则比较复杂的话，它们就会像所有隐式概念一样淹没掉被约束的对象或操作。将约束条件提取到其自己的方法中，这样就可以通过方法名来表达约束的含义，从而在设计中显式地表现出这条约束。现在这个约束条件就是一个“有名有姓”的概念了，我们可以用它的名字来讨论它。这种方式也为约束的扩展提供了空间。比这更复杂的规则很容易就会产生比其调用者（在这里就是 `pourIn()` 方法）更长的方法。这样，调用者就可以简单一些，并且只专注于处理自己的任务，而约束条件则可以根据需要进行扩展。

This separate method gives the constraint some room to grow, but there are lots of cases when a constraint just can’t fit comfortably in a single method. Or even if the method stays simple, it may call on information that the object doesn’t need for its primary responsibility. The rule may just have no good home in an existing object.

> 这种独立方法为约束预留了一定的增加空间，但是在很多时候，约束条件是无法用单独的方法来轻松表达的。或者，即使方法自身能够保持其简单性，但它可能会调用一些信息，但对于对象的主要职责而言，这些信息毫无用处。这种规则可能就不适合放到现有对象中。

Here are some warning signs that a constraint is distorting the design of its host object.

> 下面是一些警告信号，表明约束的存在正在扰乱其“宿主对象”（Host Object）的设计。

1. Evaluating a constraint requires data that does not otherwise fit the object’s definition.
2. Related rules appear in multiple objects, forcing duplication or inheritance between objects that are not otherwise a family.
3. A lot of design and requirements conversation revolves around the constraints, but in the implementation, they are hidden away in procedural code.

---

> 1. 计算约束所需的数据从定义上看并不属于这个对象。
> 2. 相关规则在多个对象中出现，造成了代码重复或导致不属于同一族的对象之间产生了继承关系。
> 3. 很多设计和需求讨论是围绕这些约束进行的，而在代码实现中，它们却隐藏在过程代码中。

When the constraints are obscuring the object’s basic responsibility, or when the constraint is prominent in the domain yet not prominent in the model, you can factor it out into an explicit object or even model it as a set of objects and relationships. (One in-depth, semiformal treatment of this subject can be found in The Object Constraint Language: Precise Modeling with UML [Warmer and Kleppe 1999].)

> 如果约束的存在掩盖了对象的基本职责，或者如果约束在领域中非常突出但在模型中却不明显，那么就可以将其提取到一个显式的对象中，甚至可以把它建模为一个对象和关系的集合。（TheObject Constraint Language:Precise Modeling with UML[Warmer and Kleppe 1999]一书中提供了关于这个问题的半正式的深入解决方案。）

Example: Review: Overbooking Policy

> 示例复核：超订策略

In Chapter 1, we worked with a common shipping business practice: booking 10 percent more cargo than the transports could handle. (Experience has taught shipping firms that this overbooking compensates for last-minute cancellations, so their ships will sail nearly full.)

> 在第 1 章中，我们讨论了一个常见的运输业务惯例：预订超出运输能力 10%的货物。（货运公司的经验表明，这种程度的超定可以抵消因客户临时取消订单而空出来的舱位，这样货轮基本能够满载起航。）

This constraint on the association between Voyage and Cargo was made explicit, both in the diagrams and in the code, by adding a new class that represented the constraint.

> 通过加入一个新类来反映 Voyage 和 Cargo 关联中的约束，该约束不管是在图表中还是在代码中都能显式地体现出来，如图 9-11 所示。

<Figures figure="9-11">The model refactored to make policy explicit</Figures>

To review the code and reasoning in the full example, see page 17.

> 要查看完整例子的代码和思路，请参阅 1.4 节示例。

### 9.2.2 Processes as Domain Objects 将过程建模为领域对象

Right up front, let’s agree that we do not want to make procedures a prominent aspect of our model. Objects are meant to encapsulate the procedures and let us think about their goals or intentions instead.

> 首先要说明的是，我们都不希望过程变成模型的主要部分。对象是用来封装过程的，这样我们只需考虑对象的业务目的或意图就可以了。

What I am talking about here are processes that exist in the domain, which we have to represent in the model. When these emerge, they tend to make for awkward object designs.

> 在这里，我们讨论的是存在于领域中的过程，我们必须在模型中把这些过程表示出来。否则当这些过程显露出来时，往往会使对象设计变得笨拙。

The first example in this chapter described a shipping system that routed cargo. This routing process was something with business meaning. A SERVICE is one way of expressing such a process explicitly, while still encapsulating the extremely complex algorithms.

> 本章的第一个例子描述了用来安排货运路线的运输系统。安排路线的过程具有业务意义。SERVICE 是显式表达这种过程的一种方式，同时它还会将异常复杂的算法封装起来。

When there is more than one way to carry out a process, another approach is to make the algorithm itself, or some key part of it, an object in its own right. The choice between processes becomes a choice between these objects, each of which represents a different STRATEGY. (Chapter 12 will look in more detail at the use of STRATEGIES in the domain.)

> 如果过程的执行有多种方式，那么我们也可以用另一种方法来处理它，那就是将算法本身或其中的关键部分放到一个单独的对象中。这样，选择不同的过程就变成了选择不同的对象，每个对象都表示一种不同的 STRATEGY。（第 12 章将会更详细地讨论如何在领域中使用 STRATEGY。）

The key to distinguishing a process that ought to be made explicit from one that should be hidden is simple: Is this something the domain experts talk about, or is it just part of the mechanism of the computer program?

> 过程是应该被显式表达出来，还是应该被隐藏起来呢？区分的方法很简单：它是经常被领域专家提起呢，还是仅仅被当作计算机程序机制的一部分？

Constraints and processes are two broad categories of model concepts that don’t come leaping to mind when programming in an object-oriented language, yet they can really sharpen up a design once we start thinking about them as model elements.

> 约束和过程是两大类模型概念，当我们用面向对象语言编程时，不会立即想到它们，然而它们一旦被我们视为模型元素，就真的可以让我们的设计更为清晰。

Some useful categories of concepts are much narrower. I’ll round out this chapter with one much more specific, yet quite common. SPECIFICATION provides a concise way of expressing certain kinds of rules, extricating them from conditional logic and making them explicit in the model.

> 有些类别的概念很实用，但它们可应用的范围要窄很多。为了使本章的讨论更全面，我会探讨一个更特殊但也非常常用的概念——规格（specification）。“规格”提供了用于表达特定类型的规则的精确方式，它把这些规则从条件逻辑中提取出来，并在模型中把它们显式地表示出来。

I developed SPECIFICATION in collaboration with Martin Fowler (Evans and Fowler 1997). The simplicity of the concept belies the subtlety in application and implementation, so there is a lot of detail in this section. There will be even more discussion in Chapter 10, where the pattern is extended. After reading the initial explanation of the pattern that follows, you may want to skim the “Applying and Implementing SPECIFICATIONS” section, until you are actually attempting to apply the pattern.

> SPECIFICATION 是我与 Martin Fowler[Evans and Fowler 1997]协作开发出来的。这个概念看起来很简单，但是应用和实现中起来却很微妙，因此在本节中会有大量的细节描述。在第 10 章中还会继续讨论 SPECIFICATION，并对这种模式进行扩展。在阅读完接下来对该模式的初步解释后，你可以跳过 9.2.4 节，等到你真正想要应用这种模式时再回来阅读也不迟。

### 9.2.3 Specification 模式：SPECIFICATION

![](figures/ch9/09inf01.jpg)

In all kinds of applications, Boolean test methods appear that are really parts of little rules. As long as they are simple, we handle them with testing methods, such as anIterator.hasNext() or anInvoice.isOverdue(). In an Invoice class, the code in isOverdue() is an algorithm that evaluates a rule. For example,

> 在所有类型的应用程序中，都会有布尔值测试方法，实际上它们只是些小规则。只要它们很简单，就可以用测试方法（如 `anIterator.hasNext()` 或 `anInvoice.isOverdue()`）来处理它们。在 Invoice 类中，`isOverdue()` 的代码是计算一条规则的算法。例如：

```java
public boolean isOverdue() {
   Date currentDate = new Date();
   return currentDate.after(dueDate);
}
```

But not all rules are so simple. On the same Invoice class, another rule, anInvoice.isDelinquent() would presumably start with testing if the Invoice is overdue, but that would just be the beginning. A policy on grace periods could depend on the status of the customer’s account. Some delinquent invoices will be ready for a second notice, while others will be ready to be sent to a collection agency. The payment history of the customer, company policy on different product lines . . . the clarity of Invoice as a request for payment will soon be lost in the sheer mass of rule evaluation code. The Invoice will also develop all sorts of dependencies on domain classes and subsystems that do not support that basic meaning.

> 但是并非所有规则都如此简单。在同一个 Invoice（发票）类中，还有另外一个规则 `anInvoice.isDelinquent()`，它一开始也是用来检查 Invoice 是否过期的，但仅仅是开始部分。根据客户账户状态的不同，可能会有宽限期政策。一些拖欠票据正准备再一次发出催款通知，而另一些则准备发给收账公司。此外，还要考虑客户的付款历史纪录、公司在不同产品线上的政策等。Invoice 作为付款请求是明白无误的，但它很快就会消失在大量杂乱的规则计算代码中。Invoice 还会发展出对领域类和子系统的各种依赖关系，而这些领域类和子系统与 Invoice 的基本含义无关。

At this point, in an attempt to save the Invoice class, a developer will often refractor the rule evaluation code into the application layer (in this case, a bill collection application). Now the rules have been separated from the domain layer altogether, leaving behind a dead data object that does not express the rules inherent in the business model. These rules need to stay in the domain layer, but they don’t fit into the object being evaluated (the Invoice in this case). Not only that, but evaluating methods swell with conditional code, which make the rule hard to read.

> 到了这一步，为了简化 Invoice 类，开发人员通常会将规则计算代码重构到应用层中（在这里就是账单收集应用程序）。现在规则已经从领域层中分离出来，留下了一个纯粹的数据对象，它将不再表达本来应该在业务模型中表示的规则。这些规则需要保留在领域层中，但是把它们放到被其约束的对象（在这里是 Invoice）里又不合适。此外，计算规则的方法中到处都是条件代码，这也使得规则变得复杂难懂。

Developers working in the logic-programming paradigm would handle this situation differently. Such rules would be expressed as predicates. Predicates are functions that evaluate to “true” or “false” and can be combined using operators such as “AND” and “OR” to express more complex rules. With predicates, we could declare rules explicitly and use them with the Invoice. If only we were in the logic paradigm.

> 那些使用逻辑编程范式的开发人员会用一种不同的方式来处理这种情况。这种规则被称为谓词。谓词是指计算结果为“真”或“假”的函数，并且可以使用操作符（如 AND 和 OR）把它们连接起来以表达更复杂的规则。通过谓词，我们可以显式地声明规则并在 Invoice 中使用这些规则。但前提是必须使用逻辑范式。

Seeing this, people have made attempts at implementing logical rules in terms of objects. Some such attempts were very sophisticated, others naive. Some were ambitious, others modest. Some turned out valuable, some were tossed aside as failed experiments. A few attempts were allowed to derail their projects. One thing is clear: As appealing as the idea is, full implementation of logic in objects is a major undertaking. (After all, logic programming is a whole modeling and design paradigm in its own right.)

> 认识到这一点后，人们已经开始尝试以对象的形式来实现逻辑规则。在这些尝试中，有些很成熟，有些则很幼稚。有些很激进，有些则很谨慎。有些被证明很有价值，有些则被当作失败的试验丢到一边。虽然项目允许进行几次这样的尝试，但是，有一件事情是很清楚的：无论这个想法多么吸引人，完全用对象来实现逻辑可是个大工程。（毕竟，逻辑编程本身就是一套建模和设计范式。）

Business rules often do not fit the responsibility of any of the obvious ENTITIES or VALUE OBJECTS, and their variety and combinations can overwhelm the basic meaning of the domain object. But moving the rules out of the domain layer is even worse, since the domain code no longer expresses the model.

> 业务规则通常不适合作为 ENTITY 或 VALUE OBJECT 的职责，而且规则的变化和组合也会掩盖领域对象的基本含义。但是将规则移出领域层的结果会更糟糕，因为这样一来，领域代码就不再表达模型了。

Logic programming provides the concept of separate, combinable, rule objects called “predicates,” but full implementation of this concept with objects is cumbersome. It is also so general that it doesn’t communicate intent as much as more specialized designs.

> 逻辑编程提供了一种概念，即“谓词”这种可分离、可组合的规则对象，但是要把这种概念用对象完全实现是很麻烦的。同时，这种概念过于通用，在表达设计意图方面，它的针对性不如专门的设计那么好。

Fortunately, we don’t really need to fully implement logic programming to get a large benefit. Most of our rules fall into a few special cases. We can borrow the concept of predicates and create specialized objects that evaluate to a Boolean. Those testing methods that get out of hand will neatly expand into objects of their own. They are little truth tests that can be factored out into a separate VALUE OBJECT. This new object can evaluate another object to see if the predicate is true for that object.

> 幸运的是，我们并不真正需要完全实现逻辑编程即可从中受益。大部分规则可以归类为几种特定的情况。我们可以借用谓词概念来创建可计算出布尔值的特殊对象。那些难于控制的测试方法可以巧妙地扩展出自己的对象。它们都是些小的真值测试，可以提取到单独的 VALUE OBJECT 中。而这个新对象则可以用来计算另一个对象，看看谓词对那个对象的计算是否为“真”。

<Figures figure="9-12"></Figures>

To put it another way, the new object is a specification. A SPECIFICATION states a constraint on the state of another object, which may or may not be present. It has multiple uses, but one that conveys the most basic concept is that a SPECIFICATION can test any object to see if it satisfies the specified criteria.

> 换言之，这个新对象就是一个规格。SPECIFICATION（规格）中声明的是限制另一个对象状态的约束，被约束对象可以存在，也可以不存在。SPECIFICATION 有多种用途，其中一种体现了最基本的概念，这种用途是：SPECIFICATION 可以测试任何对象以检验它们是否满足指定的标准。

Therefore:

> 因此：

Create explicit predicate-like VALUE OBJECTS for specialized purposes. A SPECIFICATION is a predicate that determines if an object does or does not satisfy some criteria.

> 为特殊目的创建谓词形式的显式的 VALUE OBJECT。SPECIFICATION 就是一个谓词，可用来确定对象是否满足某些标准。

Many SPECIFICATIONS are simple, special-purpose tests, as in the delinquent invoice example. In cases where the rules are complex, the concept can be extended to allow simple specifications to be combined, just as predicates are combined with logical operators. (This technique will be discussed in the next chapter.) The fundamental pattern stays the same and provides a path from the simpler to more complex models.

> 许多 SPECIFICATION 都是具有特殊用途的简单测试，就像在拖欠票据示例中的规格一样。当规则很复杂时，可以扩展这种概念，对简单的规格进行组合，就像用逻辑运算符把多个谓词组合起来一样。（这种技术将在下一章中讨论。）基本模式保持不变，并且提供了一种从简单模型过渡到复杂模型的途径。

The case of the delinquent invoice can be modeled using a SPECIFICATION that states what it means to be delinquent and that can evaluate any Invoice and make the determination.

> 拖欠票据的例子可以使用 SPECIFICATION 来建模，如图 9-13 所示。在规格中声明拖欠的含义，对任意的 Invoice 对象进行计算并做出判断。

<Figures figure="9-13">A more elaborate delinquency rule factored out as a SPECIFICATION</Figures>

The SPECIFICATION keeps the rule in the domain layer. Because the rule is a full-fledged object, the design can be a more explicit reflection of the model. A FACTORY can configure a SPECIFICATION using information from other sources, such as the customer’s account or the corporate policy database. Providing direct access to these sources from the Invoice would couple the objects in a way that does not relate to the request for payment (the basic responsibility of Invoice). In this case, the Delinquent Invoice Specification was to be created, used to evaluate some Invoices, and then discarded, so a specific evaluation date was built right in—a nice simplification. A SPECIFICATION can be given the information it will need to do its job in a simple, straightforward way.

> SPECIFICATION 将规则保留在领域层。由于规则是一个完备的对象，所以这种设计能够更加清晰地反映模型。利用工厂，可以用来自其他资源（如客户账户或者企业政策数据库）的信息对规格进行配置。之所以使用 FACTORY，是为了避免 Invoice 直接访问这些资源，因为这样会使得 Invoice 与这些资源发生不正确的关联（Invoice 的基本职责是请求付款，而这些资源与这一职责无关）。在这个例子中，我们将创建 Delinquent Invoice Specification（拖欠发票规格）来对一些发票进行评估，这个 SPECIFICATION 用过之后就被丢掉，因此可以将评估日期直接放在 SPECIFICATION 中，这真是一次不错的简化。我们可以用简单直接的方式为 SPECIFICATION 提供完成其职责所需的信息。

---

The basic concept of SPECIFICATION is very simple and helps us think about a domain modeling problem. But a MODEL-DRIVEN DESIGN requires an effective implementation that also expresses the concept. To pull that off requires digging a little deeper into how the pattern will be applied. A domain pattern is not just a neat idea for a UML diagram; it is a solution to a programming problem that retains a MODEL-DRIVEN DESIGN.

> SPECIFICATION 的基本概念非常简单，这能帮助我们思考领域建模问题。但是 MODEL-DRIVEN DRSIGN 要求我们开发出一个能够把概念表达出来的有效实现。要实现这个目标，必须要更深入地挖掘应用这个模式的方法。领域模式不仅仅是 UML 图中好的想法，也应该可以为 MODEL-DRIVEN DRSIGN 中的编程问题提供解决方案。

When you apply a pattern appropriately, you can tap into a whole body of thought about how to approach a class of domain modeling problem, and you can benefit from years of experience in finding effective implementations. There is a lot of detail in the discussion of SPECIFICATION that follows: many options for features and approaches to implementation. A pattern is not a cookbook. It lets you start from a base of experience to develop your solution, and it gives you some language to talk about what you are doing.

> 只要恰当地应用模式，就可以得出一整套如何解决领域建模问题的思路，同时也可以从这种长时间搜寻有效实现的经验中受益。下面的 SPECIFICATION 讨论详细介绍了功能和实现方法的多种选择。模式并不像菜谱那么死板。它可以让你以模式的经验为起点来开发自己的解决方案，并为你讨论手头工作提供了语言。

You may want to skim the key concepts when first reading. Later, when you run into the situation, you can come back and draw on the experience captured in the detailed discussion. Then you can go and figure out a solution to your problem.

> 在第一次阅读时，你可以快速浏览关键概念。以后碰到具体情况时，可以再回过头来阅读并从细节讨论中获取经验。然后就可以开始设计你自己的解决方案了。

### 9.2.4 Applying and Implementing SPECIFICATION SPECIFICATION 的应用和实现

Much of the value of SPECIFICATION is that it unifies application functionality that may seem quite different. We might need to specify the state of an object for one or more of these three purposes.

> SPECIFICATION 最有价值的地方在于它可以将看起来完全不同的应用功能统一起来。出于以下 3 个目的中的一个或多个，我们可能需要指定对象的状态。

1. To validate an object to see if it fulfills some need or is ready for some purpose
2. To select an object from a collection (as in the case of querying for overdue invoices)
3. To specify the creation of a new object to fit some need

---

> 1. 验证对象，检查它是否能满足某些需求或者是否已经为实现某个目标做好了准备。
> 2. 从集合中选择一个对象（如上述例子中的查询过期发票）。
> 3. 指定在创建新对象时必须满足某种需求。

These three uses—validation, selection, and building to order—are the same on a conceptual level. Without a pattern such as SPECIFICATION, the same rule may show up in different guises, and possibly contradictory forms. The conceptual unity can be lost. Applying the SPECIFICATION pattern allows a consistent model to be used, even when the implementation may have to diverge.

> 这 3 种用法（验证、选择和根据要求来创建）从概念层面上来讲是相同的。如果没有诸如 SPECIFICATION 这样的模式，相同的规则可能会表现为不同的形式，甚至有可能是相互矛盾的形式。这样就会丧失概念上的统一性。通过应用 SPECIFICATION 模式，我们可以使用一致的模型，尽管在实现时可能需要分开处理。

Validation

> 验证

The simplest use of a SPECIFICATION is validation, and it is the use that demonstrates the concept most straightforwardly.

> 规格的最简单用法是验证，这种用法也最能直观地展示出它的概念，如图 9-14 所示。

<Figures figure="9-14">A model applying a SPECIFICATION for validation</Figures>

```java
class DelinquentInvoiceSpecification extends
      InvoiceSpecification {
   private Date currentDate;
   // An instance is used and discarded on a single date

   public DelinquentInvoiceSpecification(Date currentDate) {
      this.currentDate = currentDate;
}

   public boolean isSatisfiedBy(Invoice candidate) {
      int gracePeriod =
         candidate.customer().getPaymentGracePeriod();
      Date firmDeadline =
         DateUtility.addDaysToDate(candidate.dueDate(),
            gracePeriod);
         return currentDate.after(firmDeadline);
   }

}
```

Now, suppose we need to display a red flag whenever a salesperson brings up a customer with delinquent bills. We just have to write a method in a client class, something like this.

> 现在，假设当销售人员看到一个欠账客户的信息时，系统需要显示一个红旗标识。我们只需要在客户类中编写一个方法即可，类似于下面这段代码：

```java
public boolean accountIsDelinquent(Customer customer) {
   Date today = new Date();
   Specification delinquentSpec =
      new DelinquentInvoiceSpecification(today);
   Iterator it = customer.getInvoices().iterator();
   while (it.hasNext()) {
      Invoice candidate = (Invoice) it.next();
      if (delinquentSpec.isSatisfiedBy(candidate)) return true;
   }
   return false;
}
```

Selection (or Querying)

> 选择（或查询）

Validation tests an individual object to see if it meets some criteria, presumably so that the client can act on the conclusion. Another common need is to select a subset of a collection of objects based on some criteria. The same concept of SPECIFICATION can be applied here, but implementation issues are different.

> 验证是对一个独立的对象进行测试，检查它是否满足某些标准，然后客户可能根据验证的结论来采取行动。另一种常见需求是根据某些标准从对象集合中选择一个子集。SPECIFICATION 概念同样可以在此应用，但是实现问题会有所不同。

Suppose there was an application requirement to list all customers with delinquent Invoices. In theory, the Delinquent Invoice Specification that we defined before will still serve, but in practice its implementation would probably have to change. To demonstrate that the concept is the same, let’s assume first that the number of Invoices is small, maybe already in memory. In this case, the straightforward implementation developed for validation still serves. The Invoice Repository could have a generalized method to select Invoices based on a SPECIFICATION:

> 假设应用程序的需求是列出所有拖欠发票的客户。那么从理论上来说，我们依然可以使用之前定义的 Delinquent Invoice Specification，但实际上我们可能不得不去修改它的实现。为了证明二者的概念是相同的，让我们首先假设发票的数量很少，可能已经全部装入内存了。在这种情况下，验证功能的最直接实现方式依然可用。Invoice Repository 可以用一个一般化的方法来基于 SPECIFICATION 选择 Invoice：

```java
public Set selectSatisfying(InvoiceSpecification spec) {

   Set results = new HashSet();
   Iterator it = invoices.iterator();
   while (it.hasNext()) {
      Invoice candidate = (Invoice) it.next();
      if (spec.isSatisfiedBy(candidate)) results.add(candidate);
   }

   return results;
}
```

So a client could obtain a collection of all delinquent Invoices with a single code statement:

> 这样，用一行代码即可获得所有拖欠发票的集合：

```java
Set delinquentInvoices = invoiceRepository.selectSatisfying(
   new DelinquentInvoiceSpecification(currentDate));
```

That line of code establishes the concept behind the operation. Of course, the Invoice objects probably aren’t in memory. There may be thousands of them. In a typical business system, the data is probably in a relational database. And, as pointed out in earlier chapters, the model focus tends to get lost at these intersections with other technologies.

> 上面这行代码建立了操作背后的概念。当然，Invoice 对象可能并不在内存中。也有可能会有成千上万个 Invoice 对象。在典型的业务系统中，数据很可能会存储在关系数据库中。我们在前面的章节中曾经指出，在与其他技术交互使用时，很容易分散我们对模型的注意力。

Relational databases have powerful search capabilities. How can we take advantage of that power to solve this problem efficiently while retaining the model of a SPECIFICATION? MODEL-DRIVEN DESIGN demands that the model stay in lockstep with the implementation, but it allows freedom to choose any implementation that faithfully captures the meaning of the model. Lucky for us, SQL is a very natural way to write SPECIFICATIONS.

> 关系数据库具有强大的查询能力。我们如何才能充分利用这种能力来有效解决这一问题，同时又能保留 SPECIFICATION 模型呢？MODEL-DRIVEN DESIGN 要求模型与实现保持同步，但它同时也让我们可以自由选择能够准确捕捉模型意义的实现方式。幸运的是，SQL 是用于编写 SPECIFICATION 的一种很自然的方式。

Here is a simple example, in which the query is encapsulated in the same class as the validation rule. A single method is added to the Invoice Specification and is implemented in the Delinquent Invoice Specification subclass:

> 下面是个简单的例子，其中查询被封装在验证规则所在的类中。我们在 Invoice Specification 中添加了一个方法，该方法在 Delinquent Invoice Specification 子类中得以实现：

```java
public String asSQL() {
   return
      "SELECT * FROM INVOICE, CUSTOMER" +
      "  WHERE INVOICE.CUST_ID = CUSTOMER.ID" +
      "  AND INVOICE.DUE_DATE + CUSTOMER.GRACE_PERIOD" +
      "     < " + SQLUtility.dateAsSQL(currentDate);
}
```

SPECIFICATIONS mesh smoothly with REPOSITORIES, which are the building-block mechanisms for providing query access to domain objects and encapsulating the interface to the database (see Figure 9.15).

> SPECIFICATION 与 REPOSITORY 的搭配非常合适，REPOSITORY 作为一种构造块机制，提供了对领域对象的查询访问，并且把数据库接口封装起来（参见图 9-15）。

<Figures figure="9-15">The interaction between REPOSITORY and SPECIFICATION</Figures>

Now this design has some problems. Most important, the details of the table structure have leaked into the DOMAIN LAYER; they should be isolated in a mapping layer that relates the domain objects to the relational tables. Implicitly duplicating that information here could hurt the modifiability and maintainability of the Invoice and Customer objects, because any change to their mappings now have to be tracked in more than one place. But this example is a simple illustration of how to keep the rule in just one place. Some object-relational mapping frameworks provide the means to express such a query in terms of the model objects and attributes, generating the actual SQL in the infrastructure layer. This would let us have our cake and eat it too.

> 现在的设计有一些问题。最重要的问题是，表结构的细节本应该被隔离到一个映射层中（这个映射层把领域对象关联到关系表），现在却泄漏到了 DOMAIN LAYER 中。这样一来，这些表结构信息发生了隐性的重复，因此导致对 Invoice 和 Customer 对象的修改和维护变得很麻烦，因为现在必须在多个地方跟踪它们的映射变化。但是，这个例子只是一个简单的例证，用来说明如何将规则放在一个地方。一些对象关系映射框架提供了用模型对象和属性来表达这种查询的方式，并在基础设施层中创建实际的 SQL 语句。这样就可以两全其美了。

When the infrastructure doesn’t come to the rescue, we can refactor the SQL out of the expressive domain objects by adding a specialized query method to the Invoice Repository. To avoid embedding the rule into the REPOSITORY, we have to express the query in a more generic way, one that doesn’t capture the rule but can be combined or placed in context to work the rule out (in this example, by using a double dispatch).

> 如果无法把 SQL 语句创建到基础设施中，还可以重写一个专用的查询方法并把它添加到 InvoiceRepository 中，这样就把 SQL 语句从领域对象中分离出来了。为了避免在 REPOSITORY 中嵌入规则，必须采用更为通用的方式来表达查询，这种方式不捕捉规则但是可以通过组合或放置在上下文中来表达规则（在这个例子中，使用的是双分派模式）。

```java
public class InvoiceRepository {

   public Set selectWhereGracePeriodPast(Date aDate){
      //This is not a rule, just a specialized query
      String sql = whereGracePeriodPast_SQL(aDate);
      ResultSet queryResultSet =
         SQLDatabaseInterface.instance().executeQuery(sql);
      return buildInvoicesFromResultSet(queryResultSet);
   }

   public String whereGracePeriodPast_SQL(Date aDate) {
      return
         "SELECT * FROM INVOICE, CUSTOMER" +
         "  WHERE INVOICE.CUST_ID = CUSTOMER.ID" +
         "  AND INVOICE.DUE_DATE + CUSTOMER.GRACE_PERIOD" +
         "     < " + SQLUtility.dateAsSQL(aDate);
   }

   public Set selectSatisfying(InvoiceSpecification spec) {
      return spec.satisfyingElementsFrom(this);
   }
}
```

The asSql() method on Invoice Specification is replaced with satisfyingElementsFrom(InvoiceRepository), which Delinquent Invoice Specification implements as:

> Invoice Specification 中的 `asSql()` 方法被替换为 `satisfyingElementsFrom(InvoiceRepository)`，并在 Delinquent Invoice Specification 中以如下的方式实现：

```java
public class DelinquentInvoiceSpecification {
   // Basic DelinquentInvoiceSpecification code here

   public Set satisfyingElementsFrom(
                     InvoiceRepository repository) {
      //Delinquency rule is defined as:
      //   "grace period past as of current date"
      return repository.selectWhereGracePeriodPast(currentDate);
   }
}
```

This puts the SQL in the REPOSITORY, while the SPECIFICATION controls what query should be used. The rules aren’t as neatly collected into the SPECIFICATION, but the essential declaration is there of what constitutes delinquency (that is, past grace period).

> 这段代码将 SQL 置于 REPOSITORY 中，而应该使用哪个查询则由 SPECIFICATION 来控制。SPECIFICATION 中并没有定义完整的规则，但规则的核心已位于其中——指明了什么条件构成了拖欠（即超过宽限期）。

The REPOSITORY now has a very specialized query that most likely will be used only in this case. That is acceptable, but depending on the relative numbers of Invoices that are overdue compared to those that are delinquent, an intermediate solution that leaves the REPOSITORY methods more generic may still give good performance, while keeping the SPECIFICATION more self-explanatory.

> 现在，REPOSITORY 中包含的查询非常具有针对性，可能只适用于这种情况。虽然这是可以接受的，但是根据拖欠发票在过期发票中所占数量的不同，我们可以选择一种更通用的 REPOSITORY 解决方案，使得性能仍然很好，同时又使 SPECIFICATION 的使用更易理解。

```java
public class InvoiceRepository {

   public Set selectWhereDueDateIsBefore(Date aDate) {
      String sql = whereDueDateIsBefore_SQL(aDate);
      ResultSet queryResultSet =
         SQLDatabaseInterface.instance().executeQuery(sql);
      return buildInvoicesFromResultSet(queryResultSet);
   }

   public String whereDueDateIsBefore_SQL(Date aDate) {
      return
         "SELECT * FROM INVOICE" +
         "  WHERE INVOICE.DUE_DATE" +
         "     < " + SQLUtility.dateAsSQL(aDate);
   }

   public Set selectSatisfying(InvoiceSpecification spec) {
      return spec.satisfyingElementsFrom(this);
   }
}

public class DelinquentInvoiceSpecification {
   //Basic DelinquentInvoiceSpecification code here

   public Set satisfyingElementsFrom(
                          InvoiceRepository repository) {
      Collection pastDueInvoices =
         repository.selectWhereDueDateIsBefore(currentDate);

      Set delinquentInvoices = new HashSet();
      Iterator it = pastDueInvoices.iterator();
      while (it.hasNext()) {
         Invoice anInvoice = (Invoice) it.next();
         if (this.isSatisfiedBy(anInvoice))
            delinquentInvoices.add(anInvoice);
      }
      return delinquentInvoices;
   }
}
```

We’ll take a performance hit with this code, because we pull out more Invoices and then have to select from them in memory. Whether this is an acceptable cost for the better factoring of responsibility depends entirely on circumstances. There are many ways to implement the interactions between SPECIFICATIONS and REPOSITORIES, to take advantage of the development platform, while keeping the basic responsibilities in place.

> 因为我们取出了更多 Invoice 并在内存中对其进行筛选，上面的代码会有性能方面的影响。这种以降低性能来实现更好的职责分离的代价是否可以接受完全取决于环境因素。SPECIFICATION 和 REPOSITORY 之间的交互有很多种实现方式，不但能够利用开发平台的优势，还可以保证基本职责的实施。

Sometimes, to improve performance, or more likely to tighten security, queries may be implemented on the server as stored procedures. In that case, the SPECIFICATION could carry only the parameters allowed by the stored procedure. For all that, there is no difference in the model between these various implementations. The choice of implementation is free except where specifically constrained by the model. The price comes in a more cumbersome way of writing and maintaining queries.

> 有时，为了改善性能（或者更有可能是为了加强安全性），我们可能把查询实现为服务器上的存储过程。在这种情况下，SPECIFICATION 可能只带有存储过程允许的参数。除此之外，这些不同实现之间的模型并没有什么不同。我们可以自由选择实现方式，除非模型中有特别的约束条件。这么做的代价是更加难于编写和维护查询。

This discussion barely scratches the surface of the challenges of combining SPECIFICATIONS with databases, and I’ll make no attempt to cover all the considerations that may arise. I just want to give a taste of the kind of choices that have to be made. Mee and Hieatt discuss a few of the technical issues involved in designing REPOSITORIES with SPECIFICATIONS in Fowler 2003.

> 上面的讨论基本上没有涉及将 SPECIFICATION 与数据库结合时所面临的挑战，我并不想在这里说明所有可能需要考虑的问题，而只是想简单介绍一下必须要做出的选择。Mee 和 Hieatt 在[Fowler 2002]中讨论了用规格设计 REPOSITORY 时遇到的一些技术问题。

Building to Order (Generating)

> 根据要求来创建（生成）

When the Pentagon wants a new fighter jet, officials write a specification. This specification may require that the jet reach Mach 2, that it have a range of 1800 miles, that it cost no more than \$50 million, and so on. But however detailed it is, the specification is not a design for a plane, much less a plane. An aerospace engineering company will take the specification and create one or more designs based on it. Competing companies may produce different designs, all of which presumably satisfy the original spec.

> 如果五角大楼需要一架新式的喷气式战斗机，政府官员们会先编写规格。在规格中可能会要求这架喷气机的速度达到 2 马赫，航程 1800 英里，并且成本不高于 5000 万美元，等等。无论规格有多详细，它都不是飞机的设计，更不是飞机本身。航空航天工程公司将接受这份规格并且据此创建出一个或多个设计。各个竞争公司可能会提出不同的设计，所有这些方案都需要满足原始规格。

Many computer programs generate things, and those things have to be specified. When you place a picture into a word-processing document, the text flows around it. You have specified the location of the picture, and perhaps the style of text flow. The exact placement of the words on the page is then worked out by the word processor in such a way that it meets your specification.

> 很多计算机程序都能够生成一些工件，这些工件是需要被指定的。当你在字处理软件文档中插入图片时，文字会环绕在图片周围。你已指定了图片的位置，可能也指定了文字环绕的样式。这样，字处理软件就可以按照你指定的规格来将页面上的文字摆放到正确的位置。

Although it may not be apparent at first, this is the same concept of a SPECIFICATION that was applied to validation and selection. We are specifying criteria for objects that are not yet present. The implementation will be quite different, however. This SPECIFICATION is not a filter for preexisting objects, as with querying. It is not a test for an existing object, as with validation. This time, a whole new object or set of objects will be made or reconfigured to satisfy the SPECIFICATION.

> 尽管乍看起来并不明显，但是这种 SPECIFICATION 概念与应用于验证和选择的规格并无二致。都是在为尚未创建的对象指定标准。但是，SPECIFICATION 的实现则会大不相同。这种 SPECIFICATION 与查询不同，它不用来过滤已存在对象；也与验证不同，并不用来测试已有对象。在这里，我们要创建或重新配置满足 SPECIFICATION 的全新对象或对象集合。

Without using SPECIFICATION, a generator can be written that has procedures or a set of instructions that create the needed objects. This code implicitly defines the behavior of the generator.

> 如果不使用 SPECIFICATION，可以编写一个生成器，其中包含可创建所需对象的过程或指令集。这种代码隐式地定义了生成器的行为。

Instead, an interface of the generator that is defined in terms of a descriptive SPECIFICATION explicitly constrains the generator’s products. This approach has several advantages.

> 反过来，我们也可以使用描述性的 SPECIFICATION 来定义生成器的接口，这个接口就显式地约束了生成器产生的结果。这种方法具有以下几个优点。

- The generator’s implementation is decoupled from its interface. The SPECIFICATION declares the requirements for the output but does not define how that result is reached.
- The interface communicates its rules explicitly, so developers can know what to expect from the generator without understanding all details of its operation. The only way to predict the behavior of a procedurally defined generator is to run cases or to understand every line of code.
- The interface is more flexible, or can be enhanced with more flexibility, because the statement of the request is in the hands of the client, while the generator is only obligated to fulfill the letter of the SPECIFICATION.
- Last, but not least, this kind of interface is easier to test, because the model contains an explicit way to define input into the generator that is also a validation of the output. That is, the same SPECIFICATION that is passed into the generator’s interface to constrain the creation process can also be used, in its validation role (if the implementation supports it) to confirm that the created object is correct. (This is an example of an ASSERTION, discussed in Chapter 10.)

---

> - 生成器的实现与接口分离。SPECIFICATION 声明了输出的需求，但没有定义如何得到输出结果。
> - 接口把规则显式地表示出来，因此开发人员无需理解所有操作细节即可知晓生成器会产生什么结果。而如果生成器是采用过程化的方式定义的，那么要想预测它的行为，唯一的途径就是在不同的情况下运行或去研究每行代码。
> - 接口更为灵活，或者说我们可以增强其灵活性，因为需求由客户给出，生成器唯一的职责就是实现 SPECIFICATION 中的要求。
> - 最后一点也很重要。这种接口更加便于测试，因为接口显式地定义了生成器的输入，而这同时也可用来验证输出。也就是说，传入生成器接口的用于约束创建过程的同一个 SPECIFICATION 也可发挥其验证的作用（如果实现方式能够支持这一点的话），以保证被创建的对象是正确的。（这是 ASSERTION 的例子，将会在第 10 章中讨论。）

Building to order can mean creation of an object from scratch, but it can also be a configuration of preexisting objects to satisfy the SPEC.

> 根据要求来创建可以是从头创建全新对象，也可以是配置已有对象来满足 SPECIFICATION。

Example: Chemical Warehouse Packer

> 示例化学品仓库打包程序

There is a warehouse in which various chemicals are stored in stacks of large containers, similar to boxcars. Some chemicals are inert and can be stored just about anywhere. Some are volatile and have to be stored in specially ventilated containers. Some are explosive and have to be stored in specially armored containers. There are also rules about the combinations allowed in a container.

> 以随意摆放。有些则是易挥发的，必须放于特制的通风容器中。还有一些是易爆品，必须保存于特制的防爆容器中。还有一些规则是关于如何在容器中混装化学品的。

The goal is to write software that will find an efficient and safe way to put the chemicals in the containers.

> 我们的目标是编写出一个软件，用于寻找一种安全而高效地在容器中放置化学品的方式，如图 9-16 所示。

<Figures figure="9-16">A model for warehouse storage</Figures>

We could start by writing a procedure to take a chemical and place it in a container, but instead, let’s start with the validation problem. This will force us to make the rules explicit, and it will give us a way to test the final implementation.

> 我们可以首先从编写一个过程——取出一个化学品并将其放置在一个容器中——开始，但是让我们从验证问题开始着手吧。这种方式让我们必须显式描述规则，同时也提供了一种测试最终实现的方式。

Each chemical will have a container SPECIFICATION:

> 每种化学品都有一个容器 SPECIFICATION。

![](figures/ch9/t0236_01.jpg)

Now, if we write these as Container Specifications, we should be able to take a configuration of packed containers and test to see if it meets these constraints.

> 现在，如果将这些规格编写成 Container Specification，就可以提出一种把化学品混装在容器中的配置方法，并测试它是否满足这些约束条件。

![](figures/ch9/t0236_02.jpg)

A method on Container Specification, isSatisfied(), would have to be implemented to check for needed ContainerFeatures. For example, the SPEC attached to an explosive chemical would look for the “armored” feature:

> Container Specification 的 `isSatisfied()` 方法用来检查是否存在所需的 ContainerFeature。例如，易爆化学品的规格会寻找“防爆”特性：

```java
public class ContainerSpecification {
   private ContainerFeature requiredFeature;
   public ContainerSpecification(ContainerFeature required) {
      requiredFeature = required;
   }

   boolean isSatisfiedBy(Container aContainer){
      return aContainer.getFeatures().contains(requiredFeature);
   }
}
```

Here is sample client code to set up an explosive chemical:

> 下面是设置易爆化学品的客户端示例代码：

```java
tnt.setContainerSpecification(
      new ContainerSpecification(ARMORED));
```

A method on a Container object, isSafelyPacked(), will confirm that Container has all the features specified by the Chemicals it contains:

> Container 对象的 `isSafelyPacked()` 方法用来保证 Container 具有 Chemical 要求的所有特性。

```java
boolean isSafelyPacked(){
   Iterator it = contents.iterator();
   while (it.hasNext()) {
      Drum drum = (Drum) it.next();
      if (!drum.containerSpecification().isSatisfiedBy(this))
         return false;
   }
   return true;
}
```

At this point, we could write a monitoring application that would take the inventory database and report any unsafe situations.

> 到了这一步，我们就可以编写一个监控程序，用来监视库存数据库并报告不安全状况。

```java
Iterator it = containers.iterator();
while (it.hasNext()) {
   Container container = (Container) it.next();
   if (!container.isSafelyPacked())
      unsafeContainers.add(container);
}
```

This is not the software we’ve been asked to write. It would be good to let the business people know about the opportunity, but we have been charged with designing a packer. What we have is a test for a packer. This understanding of the domain and our SPECIFICATION-based model put us in a position to define a clear and simple interface for a SERVICE that will take collections of Drums and Containers and pack them in compliance with the rules.

> 客户并没有要求我们编写这样一个软件。让业务人员知道这个程序当然很好，但客户的要求是设计一个打包程序。而现在我们得到的是打包的测试程序。这些对领域的理解和基于 SPECIFICATION 的模型使我们有能力为服务定义一个清晰而简单的接口，这个服务可接受 Drum 和 Container 集合并将它们按照规则进行打包。

```java
public interface WarehousePacker {
   public void pack(Collection containersToFill,
      Collection drumsToPack) throws NoAnswerFoundException;

      /* ASSERTION: At end of pack(), the ContainerSpecification
      of each Drum shall be satisfied by its Container.
      If no complete solution can be found, an exception shall
      be thrown. */

}
```

Now the task of designing an optimized constraint solver to fulfill the responsibilities of the Packer service has been decoupled from the rest of the application, and those mechanisms will not clutter the part of the design that expresses the model. (See “Declarative Style of Design,” Chapter 10, and COHESIVE MECHANISM, Chapter 15.) Yet the rules governing packing have not been pulled out of the domain objects.

> 现在，为履行 Packer 服务的职责，我们的任务就是设计一个优化的约束求解方案。这一任务已经与程序中的其他部分分离开来，因此其他部分的实现机制不会对这个部分的设计产生影响。（详见第 10 章和第 15 章。）然而，控制打包的规则并没有从领域对象中提取出来。

Example: A Working Prototype of the Warehouse Packer

> 示例仓库打包程序的可工作的原型

Writing the optimization logic to make the warehouse packing software work is a big job. A small team of developers and business experts have split off and have set to work on it, but they haven’t even begun to code. Meanwhile, another small team is developing the application that will allow users to pull inventory from the database, feed it to the Packer, and interpret the results. They are trying to design for the anticipated Packer. But all they can do is mock up a UI and work on some database integration code. They can’t show the users an interface with meaningful behavior to get good feedback. For the same reason, the Packer team is working in a vacuum too.

> 为了让仓库打包软件有效工作而编写优化逻辑，这是一项艰巨的工作。一个小组的开发人员和业务专家已经分头开始工作了，但是编码工作尚未进行。同时，另一个小组正在开发一个应用程序，该程序允许用户从数据库中获取库存并提交给 Packer 处理，最后分析打包结果。这个小组是面向预期的 Packer 进行设计的。但是他们能做的只是模拟一个用户界面，编写一些数据库集成代码。他们无法为用户显示一个具有实际行为的界面，因此无法获得良好的反馈。同样，Packer 小组也在闭门造车。

With the domain objects and SERVICE interface made in the warehouse packer example, the application team realizes they could build a very simple implementation of a Packer that could help the development process move along, allowing work to go forward in parallel and closing the feedback loop, which only reaches full effect with a working end-to-end system.

> 通过仓库打包程序示例中创建的领域对象和 SERVICE 接口，开发应用程序的小组认识到他们可以构建一个非常简单的 Packer 实现代码，这有助于开发工作获得进展，同时可以与其他小组协同工作并建立起反馈循环，但这只有在端到端的系统中才可以完全发挥作用。

```java
public class Container {
   private double capacity;
   private Set contents; //Drums

   public boolean hasSpaceFor(Drum aDrum) {
      return remainingSpace() >= aDrum.getSize();
   }

   public double remainingSpace() {
      double totalContentSize = 0.0;
      Iterator it = contents.iterator();
      while (it.hasNext()) {
         Drum aDrum = (Drum) it.next();
         totalContentSize = totalContentSize + aDrum.getSize();
      }
      return capacity – totalContentSize;
   }

   public boolean canAccommodate(Drum aDrum) {
      return hasSpaceFor(aDrum) &&
         aDrum.getContainerSpecification().isSatisfiedBy(this);
   }

}


public class PrototypePacker implements WarehousePacker {

   public void pack(Collection containers, Collection drums)
                                throws NoAnswerFoundException {

      /* This method fulfills the ASSERTION as written. However,
         when an exception is thrown, Containers' contents may
         have changed. Rollback must be handled at a higher
         level. */

      Iterator it = drums.iterator();
      while (it.hasNext()) {
         Drum drum = (Drum) it.next();
         Container container =
            findContainerFor(containers, drum);
         container.add(drum);
      }
   }
   public Container findContainerFor(
                 Collection containers, Drum drum)
                 throws NoAnswerFoundException {
      Iterator it = containers.iterator();
      while (it.hasNext()) {
         Container container = (Container) it.next();
         if (container.canAccommodate(drum))
            return container;
      }
      throw new NoAnswerFoundException();
   }

}
```

Granted that this code leaves a lot to be desired. It might pack sand into specialty containers and then run out of room before it packs the hazardous chemicals. It certainly doesn’t optimize revenues. But a lot of optimization problems are never solved perfectly anyway. This implementation does follow the rules that have been stated so far.

> 当然，上述代码有很多不足之处。它可能会将砂打包到特制容器中，这就导致在打包危险化学品时，特制容器已经没有多余的空间了。显然，它没有对空间的利用进行优化。但是很多优化方面的问题无论怎样都无法得到完美的解决。而这段实现代码确实遵循了到目前为止已声明过的所有规则。

Clearing Development Logjams with Working Prototypes

> 通过可工作的原型来摆脱开发僵局

One team has to wait for working code from another in order to move forward. Both teams have to wait for full integration to exercise their components or get feedback from users. This kind of congestion can often be eased by a MODEL-DRIVEN prototype of a key component, even if it does not satisfy all requirements. When implementation is decoupled from interface, then having any working implementation at all allows flexibility for project work to go in parallel. When the time is right, the prototype can be replaced by a more effective implementation. In the meantime, all other parts of the system have something to interact with during development.

> 有的团队必须要等待另一个团队编写出代码后才可以继续工作。而这两个团队都要等到代码完全整合后才可以测试组件或从用户那里获取反馈。这种僵局通常可以通过关键组件的模型驱动原型来缓解，即使原型并不满足所有需求也可以。当实现与接口分离时，只要有可以工作的实现，项目工作就可以并行地开展下去。时机成熟的时候，可以用更为高效的实现来替代原型。同时，系统中的其他部分也能在开发期间与原型进行交互。

Having this prototype lets the application developers move at full speed, including all integrations with external systems. The Packer development team also gets feedback as domain experts interact with the prototype and firm up their ideas, helping clarify requirements and priorities. The Packer team decides to take over the prototype and tweak it to test ideas.

> 有了这个原型，应用程序的开发人员就可以全速开展工作了，包括进行所有与外部系统的集成。在领域专家对原型进行研究并确认自己的想法后，Packer 开发小组也能够得到专家的反馈，从而帮助他们自己理清需求和优先级。Packer 小组决定接管这个原型并对其进行调整，以便测试他们的想法。

They also keep the interface up-to-date with their latest design, forcing refactoring of the application, and some domain objects, thereby tackling the integration problems early.

> 同时，他们还使接口与最新设计保持同步，以推动应用程序和一些领域对象的重构，从而尽早解决集成问题。

As soon as the sophisticated Packer is ready, integration is a breeze because it has been written to a well-characterized interface—the same interface and ASSERTIONS that the application was written for when interacting with the prototype.

> 一旦完成复杂的 Packer 程序，集成就是轻而易举的事情了，因为它有一个描述得很清楚的接口，应用程序在与原型交互的时候也是根据相同的接口和 ASSERTION 编写的。

It took specialists in optimization algorithms months to get it right. They benefited from the feedback they could get from users interacting with the prototype. In the meantime, all other parts of the system have something to interact with during development.

> 专家们花费了几个月的时间才得到了正确的优化算法。用户与原型交互时的反馈使他们受益匪浅。同时，系统中的其他部分在开发期间也能够与原型进行交互。

Here we have an example of a “simplest thing that could possibly work” that actually becomes possible because of a more sophisticated model. We can have a functioning prototype of a very complex component in a couple dozen lines of easily understood code. A less MODEL-DRIVEN approach would be harder to understand, would be harder to upgrade (because the Packer would be more coupled to the rest of the design), and in this case, would likely take longer to prototype.

> 这里的例子演示了如何通过更巧妙的模型使“最简单却可能非常最有效的事物”成为可能。我们可以用几十行简单易懂的代码编写出复杂组件的功能原型。如果不用 MODEL-DRIVEN DESIGN，系统会更难理解和升级（因为 Packer 与设计的其他部分更紧密地耦合在一起），在这种情况下，开发原型可能会更加耗时。
