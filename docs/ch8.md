# 第 8 章 突破

> Eight. Breakthrough

![](/figures/ch8/08inf01.jpg)

The returns from refactoring are not linear. Usually there is a marginal return for a small effort, and the small improvements add up. They fight entropy, and they are the frontline protection against a fossilized legacy. But some of the most important insights come abruptly and send a shock through the project.

> 重构的投入与回报并非呈线性关系。通常，小的调整会带来小的回报，小的改进也会积少成多。小改进可防止系统退化，成为避免模型变得陈腐的第一道防线。但是，有些最重要的理解也会突然出现，给整个项目带来巨大的冲击。

Slowly but surely, the team assimilates knowledge and crunches it into a model. Deep models can emerge gradually through a sequence of small refactorings, an object at a time: a tweaked association here, a shifted responsibility there.

> 可以确定的是，项目团队会积累、消化知识，并将其转化成模型。微小的重构可能每次只涉及一个对象，在这里加上一个关联，在那里转移一项职责。然而，一系列微小的重构会逐渐汇聚成深层模型。

Often, though, continuous refactoring prepares the way for something less orderly. Each refinement of code and model gives developers a clearer view. This clarity creates the potential for a breakthrough of insights. A rush of change leads to a model that corresponds on a deeper level to the realities and priorities of the users. Versatility and explanatory power suddenly increase even as complexity evaporates.

> 一般来说，持续重构让事物逐步变得有序。代码和模型的每一次精化都让开发人员有了更加清晰的认识。这使得理解上的突破成为可能。之后，一系列快速的改变得到了更符合用户需要并更加切合实际的模型。其功能性及说明性急速增强，而复杂性却随之消失。

This sort of breakthrough is not a technique; it is an event. The challenge lies in recognizing what is happening and deciding how to deal with it. To convey what this experience feels like, I’ll tell a true story of a project I worked on some years ago, and how we arrived at a very valuable deep model.

> 这种突破不是某种技巧，而是一个事件。它的困难之处在于你需要判断发生了什么，然后再决定如何处理。为了说明这是种什么样的经历，我将会讲述一个我几年前参与过的真实项目，以及我们是如何获得一个宝贵的深层模型的。

## 8.1 STORY OF A BREAKTHROUGH 一个关于突破的故事
After a long New York winter of refactoring, we had arrived at a model that captured some of the key knowledge of the domain and a design that did some real work for the application. We were developing a core part of a large application for managing syndicated loans in an investment bank.

> 这个故事发生在纽约，经过一个冬天的漫长重构之后，我们最终得到了能够捕捉到一些领域关键知识的模型和一个确实能在应用程序中发挥作用的设计。当时我们正在给一家投资银行开发一个大型应用程序的核心部分，该程序用于管理银团贷款。

When Intel wants to build a billion-dollar factory, they need a loan that is too big for any single lending company to take on, so the lenders form a syndicate that pools its resources to support a facility (see sidebar). An investment bank usually acts as syndicate leader, coordinating transactions and other services. Our project was to build software to track and support this whole process.

> 假如Intel想要建造一座价值10亿美元的工厂，就需要申请贷款，但贷款的额度太大，以至于任何一家借贷公司（lending company）都无法独立承担，于是这些公司就组成银团[插图]，集中它们的资源，以此来支持这种巨额信贷。投资银行通常在银团里担当领导者的角色，负责协调各种交易和其他服务。我们的项目就是要开发这样一个用于跟踪和支持以上整个过程的软件。

### 8.1.1 A Decent Model, and Yet . . . 华而不实的模型
We were feeling pretty good. Four months before, we had been in deep trouble with a completely unworkable, inherited code base, which we had since wrestled into a coherent MODEL-DRIVEN DESIGN.

> 当时，我们对于自己的成果感觉相当不错。4个月前，我们还身陷困境，因为之前留下的代码完全不可行，从那时开始我们就竭尽所能将其迁移到一个一致的MODEL-DRIVEN DESIGN中。

The model reflected in Figure 8.1 makes the common case very simple. The Loan Investment is a derived object that represents a particular investor’s contribution to the Loan, proportional to its share in the Facility.

> 图8-1中展示的模型对常见业务进行了大幅简化。Loan Investment（贷款投资）是一个派生对象，用来表示某一投资者在Loan（贷款）中所承担的股份，它与投资者在Facility（信贷）中所持有的股份成正比。

<Figures figure="8-1">A model that assumes lender shares are fixed</Figures>

What Is a “Facility”?

> Facility是什么？

A “facility” in this context is not a building. As on most projects, specialized terminology from the domain experts entered our vocabulary and became part of the UBIQUITOUS LANGUAGE. In the domain of commercial banking, a facility is a commitment by a company to lend. Your credit card is a facility that entitles you to borrow on demand up to a prearranged limit at a predetermined interest rate. When you use the card, you create an outstanding loan, and each additional charge is a drawdown against your facility that increases the loan. Finally you pay back the loan principal. You may also pay an annual fee. This is a fee for the privilege of having the card (the facility) and is independent of your loan.

> Facility（信贷）在这里并不是建筑物的意思。在大部分项目中，领域专家提供的专用术语都会变成我们自己的词汇，并成为UBIQUITOUS LANGUAGE的一部分。在商业银行领域中，信贷是公司为借款而作出的承诺。信用卡就是一种信贷，卡片持有者有权在需要时借出不超过预设限制的金额，并且以预定利息还款。当你使用信用卡时，就会产生一笔未偿贷款，每笔支出都会降低你的信贷额度，并增加你的贷款金额。最后，你需要偿还贷款本金。也许还需要缴纳年费。年费是持有信用卡（信贷）所需缴纳的费用，与你的贷款无关。

But there were some disconcerting signs. We kept stumbling over unexpected requirements that complicated the design. A major example was the creeping understanding that the shares in a Facility were only a guideline to participation in any particular loan draw-down. When the borrower requests its money, the leader of the syndicate calls all members for their shares.

> 但是这个模型已显露出了一些令人担忧的迹象。各种意料之外的需求一直困扰着我们，也使设计更加复杂。最突出的例子就是对Facility股份的理解不断深入，在提取（Drawdown）贷款时，信贷股份仅仅是放贷方投入金额的指导原则。当借款者（borrower）要求提取贷款时，银团领导者会通知所有成员按各自的股份进行支付。

When called, the investors usually cough up their share, but often they negotiate with other members of the syndicate and invest less (or more). We had accommodated this by adding Loan Adjustments to the model.

> 收到通知后，投资者通常会按自己的股份来支付，但是有时他们也会与银团其他成员协商，以求少投入（或多投入）一些。于是我们在模型中添加了Loan Adjustment（贷款调整）以反映这一事实。

<Figures figure="8-2">A model incrementally changed to solve problems. Loan Adjustments track departures from the share a lender originally agreed to in the Facility.</Figures>

Refinements of this kind allowed us to keep up as the rules of various transactions became clearer. But complexity was increasing, and we did not seem to be converging quickly onto really solid functionality.

> 这种类型的精化使我们能够越来越清楚地理解各种交易规则。但同时，模型的复杂度也在不断增加，并且看起来我们无法很快从模型中提炼出真正健壮的功能。

Even more troubling were subtle rounding inconsistencies that we had not been able to squash with increasingly complex algorithms. True, in a $100 million (MM) deal, no one cares about where the extra pennies go, but bankers don’t trust software that cannot meticulously account for those pennies. We began to suspect that our difficulties were symptomatic of a basic design problem.

> 更麻烦的是尽管算法越来越复杂，我们却无法解决舍入运算所带来的细微差别。在1亿美元的交易中，确实没有人会在意几美分的去向，但是银行家是不会信任无法精确计算到美分的软件的。我们开始怀疑我们所遇到的难题可能是因为基本设计存在问题。

### 8.1.2 The Breakthrough 突破
Suddenly one week it dawned on us what was wrong. Our model tied together the Facility and Loan shares in a way that was not appropriate to the business. This revelation had wide repercussions. With the business experts nodding, enthusiastically helping—and, I dare say, wondering what took us so long—we hashed out a new model on a whiteboard. Although the details hadn’t jelled yet, we knew the crucial feature of the new model: shares of the Loan and those of the Facility could change independently of each other. With that insight, we walked through numerous scenarios using a visualization of the new model that looked something like this:

> 在项目进行过程中，我们突然领悟到了问题的所在。我们在模型中把Facility的股份和Loan的股份绑定到一起，而这种方式并不适用于实际的业务。这一发现得到了广泛的认可。业务专家点头称是，并开始热情地给予帮助（我敢说他们一定还在奇怪我们怎么花了这么长时间才明白这一点），我们迅速在白板上创建了一个新模型。虽然细节问题尚未确定，但是我们已经知道新模型的关键特征了：Loan的股份和Facility的股份可以在互不影响的前提下独立发生改变。有了这层认知，我们利用与下图类似的模型图走查了许多场景：

<Figures figure="8-3">A drawdown distributed based on Facility shares</Figures>

This diagram says that the borrower has chosen to draw an initial $50MM from the $100MM committed under the Facility. The three lenders chip in their shares in exact proportion to the Facility shares, resulting in a $50MM Loan divided among the lenders.

> 这张图表明Facility的总额是1亿美元，而借款者选择从中提取的第一笔Loan金额是5000万美元。3个放贷方按照各自原先承诺的Facility的股份来支付，这样5000万的Loan就被分配到了这3个放贷方头上。

Then, in Figure 8.4, the borrower draws an additional $30MM, bringing his outstanding Loan to $80MM, still under the $100MM limit of the Facility. This time, Company B chooses not to participate, letting Company A take an extra share. The shares of the draw-down reflect these investment choices. When the drawdown amounts are added to the Loan, the shares of the Loan are no longer proportional to the shares of the Facility. This is common.

> 随后，借款者又提取了另一笔3000万美元的货款（如图8-4所示），这样他的未偿Loan就达到了8000万美元，依然在Facility的1亿美元限额之内。这次，公司B决定不参与Loan，而由公司A来承担这部分额外的股份。各个放贷方在借款者提取贷款的过程中所支付的股份反映了它们的投资选择。当Loan的提取额不断增加时，Loan的股份份额就不再与Facility的股份成比例了。这种现象很普遍。

<Figures figure="8-4">Lender B opts out of a second drawdown.</Figures>

<Figures figure="8-5">Principal payments are always distributed proportional to shares in the outstanding Loan.</Figures>

When the borrower pays down the Loan, the money is divided among the lenders according to the shares of the Loan, not the Facility. Likewise, interest payments will be divided according to the Loan shares.

> 当借款者偿还Loan时，所偿还的金额会根据Loan的股份分配给各放贷方，而不是根据Facility的股份来划分。同样，利息支付也会按照Loan的股份进行分配。

<Figures figure="8-6">Fee payments are always distributed proportionally to shares in the Facility.</Figures>

On the other hand, when the borrower pays a fee for the privilege of having the Facility available, this money is divided according to the Facility shares, regardless of who actually has lent money. The Loan is unchanged by fee payments. There are even scenarios in which lenders trade shares of fees separately from their shares of interest, and so on.

> 另一方面，当借款者为享有Facility权而支付费用时，这笔钱是按照Facility的股份划分的，而不考虑放贷方是否借出了钱。Loan不会因费用支付而发生变化。甚至还有这种情况，放贷方单独交易费用股份，与利息股份等无关。

### 8.1.3 A Deeper Model 更深层模型
We had two deep insights. First was the realization that our “Investments” and “Loan Investments” were just two special cases of a general and fundamental concept: shares. Shares of a facility, shares of a loan, shares of a payment distribution. Shares, shares everywhere. Shares of any divisible value.

> 我们得到了两个深层理解。其一是意识到“投资”和“Loan投资”是“股份”这个常规基础概念的两种特例。信贷股份、货款股份、支付比例股份，这些都是股份，股份无处不在。任何可分配的价值都是股份。

A few tumultuous days later I had sketched a model of shares, drawing on the language used in the discussions with experts and the scenarios we had explored together.

> 经过几天忙碌的工作，我根据与专家讨论时所使用的语言以及我们一起研究的场景，初步搭建起了一个股份模型，如图8-7所示。

<Figures figure="8-7">An abstract model of shares</Figures>

I also sketched a new loan model to go with it.

> 我同时也草绘了一个与股份模型搭配的新贷款模型。

<Figures figure="8-8">The Loan model using Share Pie</Figures>

There were no longer specialized objects for the shares of a Facility or a Loan. They both were broken down into the more intuitive “Share Pie.” This generalization allowed the introduction of “shares math,” vastly simplifying the calculation of shares in any transaction, and making those calculations more expressive, concise, and easily combined.

> 现在Facility股份和Loan股份不再由专用对象来表示了。它们都被分解成了更直观的Share Pie。这种泛化引入了“股份数学”的概念，极大地简化了所有交易中的股份计算，同时也使这些计算更富有表达力、更简洁且更易于组合。

But most of all, problems went away because the new model removed an inappropriate constraint. It freed the Loan’s Shares to depart from the proportions of the Facility’s Shares, while keeping in place the valid constraints on totals, fee distributions, and so on. The Share Pie of the Loan could be adjusted directly, so the Loan Adjustment was no longer needed, and a large amount of special-case logic was eliminated.

> 但最重要的是，新模型删除了不恰当的约束，这使得我们的问题迎刃而解。Loan的Share因而无需与Facility的Share成比例，同时新模型仍然保留着对总额、费用分配等的有效约束。我们可以直接调整Loan的Share Pie，因此新模型也不再需要Loan Adjustment和大量处理特殊情况的逻辑了。

The Loan Investment had disappeared, and at this point we realized that “loan investment” was not a banking term. In fact, the business experts had told us a number of times that they didn’t understand it. They had deferred to our software knowledge and assumed it was useful to the technical design. Actually, we had created it based on our incomplete understanding of the domain.

> 新模型中不再包含Loan Investment对象，我们此时才意识到“贷款投资”并不是一个银行业术语。事实上，业务专家早已多次告诉我们，他们不明白“贷款投资”是什么意思。但是他们还是尊重我们在软件方面的知识，并假定它对技术方面的设计是有所帮助的。而事实上，我们之所以创建它是因为没有完全理解领域。

Suddenly, on the basis of this new way of looking at the domain, we could run through every scenario we had ever encountered relatively effortlessly, much more simply than ever before. And our model diagrams made perfect sense to the business experts, who had often indicated that the diagrams were “too technical” for them. Even just sketching on a whiteboard, we could see that our most persistent rounding problems would be pulled out by the roots, allowing us to scrap some of the complicated rounding code.

> 这种看待领域的新方法使我们立即就可以毫不费力地处理之前遇到的所有场景，处理过程要比以往简单许多。业务专家认为我们的模型图非常合理，他们曾经指出我们之前的模型图对他们来说“技术性太强”了。即使只是在白板上画出草图，我们也能看出新模型能够彻底解决长期困扰我们的舍入计算问题，我们可以不再使用复杂的舍入代码了。

Our new model worked well. Really, really well.

> 新模型的效果很好。非常非常好。

And we all felt sick!

> 而我们都已疲惫不堪了！

### 8.1.4 A Sobering Decision 冷静决策
You might reasonably assume that we would have been elated at this point. We were not. We were under a severe deadline; the project was already dangerously behind schedule. Our dominant emotion was fear.

> 你也许会认为我们在那时一定会洋洋自得。但我们没有。项目的期限很紧，而我们的进度已严重落后了。所以，那时我们最强烈的感受就是担忧。

The gospel of refactoring is that you always go in small steps, always keeping everything working. But to refactor our code to this new model would require changing a lot of supporting code, and there would be few, if any, stable stopping points in between. We could see some small improvements we could make, but none that would take us closer to the new concept. We could see a sequence of small steps to get there, but parts of the application would be disabled along the way. And this was before the age when automated tests were widely used on such projects. We had none, so there was bound to be unforeseen breakage.

> 重构的原则是始终小步前进，始终保持系统正常运转。但是要按照这个新模型来重构则需要修改大量的支持代码，在重构的过程中，系统几乎无法正常运转。我们能够看出一些力所能及的微小改进，但这些改进无法让我们实现新的领域概念。我们也知道通过一系列小改动可以实现新模型，但是在这个过程中必然会导致程序的一部分功能无法正常工作。而且在当时，自动化测试还没有广泛应用于这种项目。我们一无所有，所以肯定会出现一些让我们始料不及的破坏。

And it was going to take effort. We were already exhausted from months of pushing.

> 此外，重构是需要花费精力去实现的。但几个月以来，我们一直压力重重，早已精疲力尽了。

At this point, we had a meeting with our project manager that I will never forget. Our manager was an intelligent and bold man. He asked a series of questions:

> 这时，我们与项目经理开了一次会，这次会议令我终生难忘。我们的项目经理是个睿智而勇敢的人。他问了我们许多问题：

- Q: How long would it take to get back to current functionality with the new design?
- A: About three weeks.
- Q: Could we solve the problems without it?
- A: Probably. But no way to be sure.
- Q: Would we be able to move forward in the next release if we didn’t do it now?
- A: Forward movement would be slow without the change. And the change would be much harder once we had an installed base.
- Q: Did we think it was the right thing to do?
- A: We knew the political situation was unstable, so we’d cope if we had to. And we were tired. But, yes, it was a simpler solution that fit the business much better. In the long run it was lower risk.

---

> - Q1：如果采用新设计，需要多久才能重新实现已有功能？
> - A1：大约3周。
> - Q2：不用新设计可以解决问题吗？
> - A2：有可能。但我们无法保证。
> - Q3：如果现在不采用新设计，可以继续进行下一个版本的开发吗？
> - A3：如果不做修改，开发进度会非常缓慢。而且我们的系统一旦有了客户群，再做修改就会变得更加困难。
> - Q4：这是不是正确的行动？
> - A4：我们知道目前的局面很不稳定，如果不是非做不可，我们也可以将就。而且我们都很疲惫了。但是，是的，这是个更加简单的解决方案，也更符合业务需求。从长远角度来看，它会降低风险。

He gave us the go-ahead and told us he would handle the heat. I’ve always had tremendous admiration for the courage and trust it took for him to make that decision.

> 他给我们开了绿灯，并告诉我们他会控制好局面。做出这种决定需要无比的勇气和信心，这使我一直对他钦佩不已。

We busted our butts and got it done in three weeks. It was a big job, but it went surprisingly smoothly.

> 我们全力以赴，在3个星期内完成了任务。这是个巨大的工程，但是却进展得异常顺利。

### 8.1.5 The Payoff 成果
The mystifyingly unexpected requirement changes stopped. The rounding logic, though never exactly simple, stabilized and made sense. We delivered version one and the way was clear to version two. My nervous breakdown was narrowly averted.

> 项目需求不再有意外的、难以捉摸的改变了。舍入逻辑的实现虽然并不简单，却很稳定并且合理。我们交付了软件的第一个版本，第二个版本的开发思路也很清晰了。我的神经衰弱也多少有了好转。

As version two evolved, this Share Pie became the unifying theme of the whole application. Technical people and business experts used it to discuss the system. Marketing people used it to explain the features to prospective customers. Those prospects and customers immediately grasped it and used it to discuss features. It truly became part of the UBIQUITOUS LANGUAGE because it got to the heart of what loan syndication is about.

> 在进行第二个版本的开发时，Share Pie成了整个程序的统一主题。技术人员和业务专家利用它来对系统进行讨论。市场人员使用它来向预期客户解释系统特性。这些预期客户和其他的客户都能立刻理解它，并且可以马上用它来讨论特性。由于它抓住了银团货款的核心问题，所以它真正成为了UBIQUITOUS LANGUAGE的一部分。

## 8.2 OPPORTUNITIES 机遇
When the prospect of a breakthrough to a deeper model presents itself, it is often scary. Such a change has higher opportunity and higher risk than most refactorings. And timing may be inopportune.

> 当突破带来更深层的模型时，通常会令人感到不安。与大部分重构相比，这种变化的回报更多，风险也更高。而且突破出现的时机可能很不合时宜。

Much as we might like it to be otherwise, progress isn’t a smooth ride. The transition to a really deep model is a profound shift in your thinking and demands a major change to the design. On many projects the most important progress in model and design come in these breakthroughs.

> 尽管我们希望进展顺利，但往往事与愿违。过渡到真正的深层模型需要从根本上调整思路，并且对设计做大幅修改。在很多项目中，建模和设计工作最重要的进展都来自于突破。

## 8.3 FOCUS ON BASICS 关注根本
Don’t become paralyzed trying to bring about a breakthrough. The possibility usually comes after many modest refactorings. Most of the time is spent making piecemeal improvements, with model insights emerging gradually during each successive refinement.

> 不要试图去制造突破，那只会使项目陷入困境。通常，只有在实现了许多适度的重构后才有可能出现突破。在大部分时间里，我们都在进行微小的改进，而在这种连续的改进中模型深层含义也会逐渐显现。

To set the stage for a breakthrough, concentrate on knowledge crunching and cultivating a robust UBIQUITOUS LANGUAGE. Probe for important domain concepts and make them explicit in the model (as discussed in Chapter 9). Refine the design to be suppler (see Chapter 10). Distill the model (see Chapter 15). Push on these more predictable levers, which increase clarity—usually a precursor of breakthroughs.

> 要为突破做好准备，应专注于知识消化过程，同时也要逐渐建立健壮的UBIQUITOUSLANGUAGE。寻找那些重要的领域概念，并在模型中清晰地表达出来（参见第9章）。精化模型，使其更具柔性（参见第10章）。提炼模型（参见第15章）。利用这些更容易掌握的手段使模型变得更清晰，这通常会带来突破。

Don’t hold back from modest improvements, which gradually deepen the model, even if confined within the same general conceptual framework. Don’t be paralyzed by looking too far forward. Just be watchful for the opportunity.

> 不要犹豫着不去做小的改进，这些改进即使脱离不开常规的概念框架，也可以逐渐加深我们对模型理解。不要因为好高骛远而使项目陷入困境。只要随时注意可能出现的机会就够了。

## 8.4 EPILOGUE: A CASCADE OF NEW INSIGHTS 后记：越来越多的新理解
That breakthrough got us out of the woods, but it was not the end of the story. The deeper model opened unexpected opportunities to make the application richer and the design clearer.

> 突破使我们走出了困境，但故事并没有就此结束。更深层次的模型为我们带来了意想不到的机会，它使应用程序的功能更加丰富，设计也更加清晰。

Just weeks after the release of the Share Pie version of the software, we noticed another awkward aspect of the model that was complicating the design. An important ENTITY was missing, its absence leaving extra responsibilities to be taken up by other objects. Specifically, there were significant rules governing loan drawdowns, fee payments, and so on, and all this logic was crammed into various methods on the Facility and Loan. These design problems, which had been barely noticeable before the Share Pie breakthrough, became obvious with our clearer field of vision. Now we noticed terms popping up in our discussions that were nowhere to be found in the model—terms such as “transaction” (meaning a financial transaction)—that we started to realize were being implied by all those complicated methods.

> 在Share Pie版本的程序发布几周之后，我们注意到在模型中还存在一个使设计变得复杂的地方。我们漏掉了一个重要的ENTITY，结果是本来应该由它承担的职责不得不由其他对象来完成。具体来说就是提取货款、缴纳费用等业务是由一些重要的规则控制的，而所有这些逻辑都分散在Facility和Loan中的各种方法里了。这些设计问题在Share Pie突破出现之前几乎没有引起我们的注意，但是随着我们对领域的理解日渐清晰，它们也变得明显起来。现在我们开始注意到，那些经常在讨论中出现的术语（如“交易”，代表一次金融交易）并没有体现在模型中，反而隐含在了那些复杂的方法里。

Following a process similar to the one described earlier (although, thankfully, under much less time pressure) led to yet another round of insights and a still deeper model. This new model made those implicit concepts explicit, as kinds of Transactions, and at the same time simplified the Positions (an abstraction including the Facility and Loan). It became easy to define the diverse transactions we had, along with their rules, negotiating procedures, and approval processes, and all in relatively self-explanatory code.

> 经过与之前类似的过程（但所幸的是，我们有了更加充足的时间），我们对领域的理解又向前迈进了一步，并获得了一个更深层次的模型。这个新模型不但使所有隐含的概念显现了出来，如Transaction，以及一个简化的Position（包括Facility和Loan的抽象类）。于是定义各种交易、交易规则、协商程序和审批流程就变得轻而易举了，而且实现这些概念的代码也相对来说变得更好理解了。

<Figures figure="8-9">Another model breakthrough that followed several weeks later. Constraints on Transactions could be expressed with easy precision.</Figures>

As is often the case after a real breakthrough to a deep model, the clarity and simplicity of the new design, combined with the enhanced communication based on the new UBIQUITOUS LANGUAGE, had led to yet another modeling breakthrough.

> 通常，在经过一次真正的突破并获得了深层模型之后，所获得的新设计变得更加清晰简单，新的UBIQUITOUS LANGUAGE也会增进沟通，于是又促成了下一次建模突破。

Our pace of development was accelerating at a stage where most projects are beginning to bog down in the mass and complexity of what has already been built.

> 当大部分项目由于规模和复杂度的累积而举步维艰时，我们的项目却正在加速前进。