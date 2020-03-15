# 结束语

> Conclusion

## EPILOGUES 后记

Although it is very satisfying working on a cutting-edge project and experimenting with interesting ideas and tools, for me it is a hollow experience if the software does not find productive use. In fact, the true test of success is how the software serves over a period of time. I have been able to follow the stories of some of my former projects over the years.

> 虽然开发最前沿的项目并体验有趣的思想和工具会带来巨大的成就感，但我认为如果软件得不到有效的应用，那么一切都将成为空谈。事实上，检验软件成功与否的最有效的方法是让它运行一段时间。近年来，我从自己经历过的项目中总结出了一些经验。

I’ll discuss here five of those, each of which made a serious attempt at domain-driven design, though not systematically and not by that name, of course. All of these projects did deliver software: some managed to carry through and produce a model-driven design, while one slipped off that track. Some of the applications continued to grow and change for many years, while one stagnated and one died young.

> 这里我们来谈一下其中 5 个项目，每个项目都认真尝试了领域驱动设计，但它们并没有系统地采用这种方法，当然也没有在这个名头下进行开发。这 5 个项目都完成了软件交付工作，其中 4 个项目坚持采用模型驱动的设计方法，并得到了相应的设计结果，而有一个项目却偏离了轨道。一些应用程序多年来一直在发展和改变，但有一个程序一直没有进步，还有一个很早就结束了。

The PCB design software described in Chapter 1 was a smash hit among beta users in the field. Unfortunately, the start-up company that had initiated the project utterly failed in its marketing function and was eventually euthanized. The software is now used by a handful of PCB engineers who have old copies they kept from the beta program. Like any orphan software, it will continue to work until there is some fatal change to one of the programs with which it is integrated.

> 第 1 章中描述的 PCB 设计软件的 beta 版本在业内引起了一次很大的轰动，但遗憾的是，发起该项目的公司在它的营销方面做得非常失败，最终公司草草收场。少数一些保留了 beta 版副本的 PCB 工程师现在仍在使用该软件。像所有缺乏支持的软件一样，它会被继续使用下去，直到其中集成的某个程序发生重大改变为止。

The loan software whose story was told in Chapter 9 thrived and evolved along much the same track for three years after the breakthrough I wrote about. At that point, the project was spun off as an independent company. In the turmoil of this reorganization, the project manager who had led the project from the beginning was ejected, and some of the core developers left with him. The new team had a somewhat different design philosophy, not as fully committed to object modeling. But they retained a distinct domain layer with complex behavior and continued to value domain knowledge on the development team. Seven years after the spin-off, the software continues to be enhanced with new features. It is the leading application in its field and serves an increasing number of client institutions, as well as being the largest revenue stream for the company.

> 第 9 章中介绍的贷款软件在我提到的突破之后，经历了 3 年波澜不惊的发展。在此之后，该项目脱离出来，成为一家独立的公司。在重组的过程中，从一开始就领导这个项目的经理被解聘了，一些核心开发人员也随他一起离开。新的团队有一套稍微不同的设计思想，他们不是完全遵循对象建模。但保留了具有复杂行为的独特的领域层，而且在他们的开发团队中依旧非常重视领域知识。在新公司独立运转 7 年后，该软件仍在不断增加新的功能。它在业内是该领域领先的应用程序，正在为越来越多的客户机构服务，也是公司最大的收入来源。

![](figures/ap01inf01.jpg)

A Newly Planted Olive Grove

Until the domain-driven approach is more widespread, the interesting software on many projects will be built in a short, highly productive interval. Eventually the project will transform into something more conventional that may not be able to fully exploit, much less enhance, the power of the deep models that were distilled earlier. I could wish for more, but truly those are successes that deliver sustained value to users over many years.

> 在领域驱动方法广为流行之前，很多项目的软件将创建得更快、更高效。但项目最终仍不免按传统的套路发展，导致先前精炼的深层模型无法被充分利用，更谈不上去增强它的能力了。可能我的期望过高了，但如果做不到这一点，项目就无法在长达数年的时间内为用户提供稳定的价值。

On one project I paired with another developer to write a utility the customer needed to produce its core product. The features were fairly complicated and combined in intricate ways. I enjoyed the project work and we produced a supple design with an ABSTRACT CORE. When this software was handed off, that was the end of involvement for everyone who had initially developed it. Because it was such an abrupt transition, I expected that the design features which supported the combinable elements might be confusing and might get replaced by more typical case logic. This did not initially happen. When we handed off, the package included a thorough test suite and a distillation document. The new team members used that document to guide their explorations, and as they looked into things, they became excited by the possibilities the design presented. When I heard their comments a year later, I realized that the UBIQUITOUS LANGUAGE had sparked across to the other team and stayed alive, continuing to evolve.

> 我曾经与另一位开发人员结对做过一个项目，我们为客户编写一个实用工具，客户用这个工具来开发他们的核心产品。所需的功能及功能组合相当复杂。我很喜欢这个项目的工作，我们也开发出了一个具有 ABSTRACT CORE 的柔性设计。这个软件交付以后，每个人涉及的工作也就结束了。由于项目交接之后就与我们无关了，交接过程显得有些突兀，因此我估计那些用来支持元素组合的特性可能很难被客户理解，而且有可能被替换为更典型的条件选择逻辑。但这种情况并没有马上发生。当我们交付软件的时候，程序包含一个完整的测试套件和一个精炼文档。新的团队成员用这个文档来指导他们的工作。他们对这个软件做了一番研究之后，很高兴地发现我们的设计提供了各种可能性。当我在一年之后听到他们的评论时，我知道我们的 UBIQUITOUS LANGUAGE 已经传递到了新团队，而且这种语言仍然充满活力并继续发展。

![](figures/ap01inf02.jpg)

Seven Years Later

Then, another year later, I heard a different story. The team had encountered new requirements that the developers didn’t see any way to accomplish within the inherited design. They had been forced to change the design almost beyond recognition. As I probed for more details, I could see that aspects of our model would have made solving those problems awkward. It is precisely during such moments when a breakthrough to a deeper model is often possible, especially when, as in this case, the developers had accumulated deep knowledge and experience in the domain. In fact, they had had a rush of new insights and ended up transforming the model and design based on those insights.

> 又一年过去了，我听到一个完全不同的故事。团队遇到了新的需求，开发人员们发现用原来的设计已经无法满足这些新需求。他们不得不修改设计，这一改几乎使原来的设计面目全非。在了解了一些细节之后，我发现我们原来的模型用来解决这些问题时显然十分蹩脚。往往就是在这个时候有可能产生一次突破，形成一个更深层的模型，特别是在这个例子中，开发人员已经积累了大量的深层领域知识和经验。事实上，他们确实形成了新的理解，并最终根据这些理解对模型和设计进行了转换。

They told me this story carefully, diplomatically, expecting, I suppose, that I would be disappointed by their discarding of so much of my work. I am not that sentimental about my designs. The success of a design is not necessarily marked by its stasis. Take a system people depend on, make it opaque, and it will live forever as untouchable legacy. A deep model allows clear vision that can yield new insight, while a supple design facilitates ongoing change. The model they came up with was deeper, better aligned with the real concerns of the users. Their design solved real problems. It is the nature of software to change, and this program has continued to evolve in the hands of the team that owns it.

> 他们小心翼翼地、委婉地告诉了我这件事情，我猜他们可能是担心我在听到如此多的先前工作被丢弃后会感到不满。但是我对自己的设计并没有这种守旧情结。一个成功的设计并不一定要永远保持不变。如果把人们赖以工作的一个系统封闭起来，那么它将会变为一项永久的、谁也不敢碰的遗留资产。深层模型可以使人们清楚地看懂它，并据此产生新的理解，而柔性设计可以促进后续的修改。他们提出了一个更深层的模型，这个模型更符合用户关心的需求。他们的设计解决了实际问题。变更是软件的固有性质，这个程序在拥有它的团队的手中得到了继续发展。

The shipping examples scattered through the book are loosely based on a project for a major international container-shipping company. Early on, the leadership of the project was committed to a domain-driven approach, but they never produced a development culture that could fully support it. Several teams with widely different levels of design skill and object experience set out to create modules, loosely coordinated by informal cooperation between team leaders and by a customer-focused architecture team. We did develop a reasonably deep model of the CORE DOMAIN, and there was a viable UBIQUITOUS LANGUAGE.

> 本书很多章节中都提到过运输的例子，这个例子大体上是基于一家大型国际集装箱运输公司的项目。在早期，项目的领导者们采用了领域驱动的方法，但他们一直没有建立一种支持该方法的开发文化。几支具有不同设计技术水平和对象经验的团队分头开始创建模块，但他们之间的工作只是由团队领导者之间的非正式合作和一个主要负责客户事务的架构团队来粗略地协调。我们确实开发出了一个合理的、深层的 CORE DOMAIN 模型，也有一个可使用的 UBIQUITOUS LANGUAGE。

But the company culture fiercely resisted iterative development, and we waited far too long to push out a working internal release. Therefore, problems were exposed at a late stage, when they were more risky and expensive to fix. At some point, we discovered specific aspects of the model were causing performance problems in the database. A natural part of MODEL-DRIVEN DESIGN is the feedback from implementation problems to changes in the model, but by that time there was a perception that we were too far down the road to change the fundamental model. Instead, changes were made to the code to make it more efficient, and its connection to the model was weakened. The initial release also exposed scaling limitations in the technical infrastructure that threw a scare into management. Expertise was brought in to fix the infrastructure problems, and the project bounced back. But the loop was never closed between implementation and domain modeling.

> 但公司的文化非常不利于迭代开发，因此我们过了很长时间才形成了一个可用的内部版本。因此，问题到了后期才暴露出来，而此时修复的话就要冒很大的风险并且要付出高昂的代价。我们发现模型的某些方面会引起数据库性能问题。反馈（无论是实现问题，还是模型修改）是 MODEL-DRIVEN DESIGN 的一个自然的部分，但那时我们感觉到自己已经在开发这条路上走得太远了，以至于很难再修改模型的基本部分了。相反，我们对代码做了修改，使它更有效，但代码与模型的联系却被削弱了。最初的版本也暴露出在技术基础设施扩展方面的局限性，这使管理层感到担忧。项目组聘请了专家来修复基础设施问题，项目恢复了开发。但实现与领域建模之间却始终没有形成一个闭环。

A few teams delivered fine software with complex capabilities and expressive models. Others delivered stiff software that reduced the model to data structures, though even they retained traces of the UBIQUITOUS LANGUAGE. Perhaps a CONTEXT MAP would have helped us as much as anything, as the relationship between the output of the various teams was haphazard. Yet that CORE model carried in the UBIQUITOUS LANGUAGE did help the teams ultimately to glue together a system.

> 有几个团队交付了不错的软件——实现了复杂的功能，模型也表达得很清楚。而有些团队交付的软件却很生硬，模型退化为数据结构（尽管他们保留了 UBIQUITOUS LANGUAGE 的痕迹）。可能使用 CONTEXT MAP 会有所帮助，因为各个团队的开发结果之间没有什么必然联系。然而，用 UBIQUITOUS LANGUAGE 开发出来的 CORE 模型确实帮助团队把各自的工作整合为一个系统。

Although reduced in scope, the project replaced several legacy systems. The whole was held together by a shared set of concepts, though most of the design was not very supple. It has itself largely fossilized into legacy now, years later, but it still serves the global business 24 hours a day. Although the more successful teams’ influence gradually spread, time runs out eventually, even in the richest company. The culture of the project never really absorbed MODEL-DRIVEN DESIGN. New development today is on different platforms and is only indirectly influenced by the work we did—as the new developers CONFORM to their legacy.

> 虽然范围缩小了，项目还是替换了几个遗留系统。尽管大部分设计都不够灵活，但整体设计还是通过一个共享的概念集凝聚到了一起。经过几年之后，系统本身已经退化为一项遗留资产，但它仍在为全球业务提供全天候的服务。虽然成功团队的影响渐渐扩大，但整个项目最后还是走到了尽头，即便公司有着雄厚的财力。项目文化从来没有真正采纳过 MODEL-DRIVEN DESIGN。现在的新开发是在不同平台上进行的，我们的工作只是间接影响他们，因为新开发人员需要遵从（CONFORM）他们的遗留系统。

In some circles, ambitious goals like those the shipping company initially set have been discredited. Better, it seems, to make little applications we know how to deliver. Better to stick to the lowest common denominator of design to do simple things. This conservative approach has its place, and allows for neatly scoped, quick-response projects. But integrated, model-driven systems promise value that those patchworks can’t. There is a third way. Domain-driven design allows piecemeal growth of big systems with rich functionality, by building on a deep model and supple design.

> 在一些领域中，像运输公司最初设定的那样宏伟的目标是不可信的。更好的做法是开发小的、确保能够交付的应用程序，并坚持用最简单的设计来实现简单的功能。这种保守的方法有它自己的用武之地，可以使项目范围保持精简，并且使项目具有快速响应的能力。但集成的、模型驱动的系统所提供的价值是那些拼凑起来的系统无法提供的。但我们还有一种方法，那就是使用领域驱动设计构建深层模型和柔性设计，这样，具有丰富功能的大型系统就能够逐步增长。

I’ll close this list with Evant, a company that develops inventory management software, where I played a secondary supporting role and contributed to an already strong design culture. Others have written about this project as a poster child of Extreme Programming, but what is not usually remarked upon is that the project was intensely domain-driven. Ever deeper models were distilled and expressed in ever more supple designs. This project thrived until the “dot com” crash of 2001. Then, starved for investment funds, the company contracted, software development went mostly dormant, and it seemed that the end was near. But in the summer of 2002, Evant was approached by one of the top ten retailers in the world. This potential client liked the product, but it needed design changes to allow the application to scale up for an enormous inventory planning operation. It was Evant’s last chance.

> 最后我们来说一下 Evant，这是一家开发库存管理系统的公司，我曾在这家公司做过辅助支持的工作，也为公司已经很健壮的设计文化作出了一点贡献。有些人把这个项目看作是极限编程的典型代表，但很少有人注意到它也广泛应用了领域驱动设计。在这个项目中，模型被不断精炼，并且用更柔性的设计表达出来。这个项目在 2001 年的“dot com”泡沫破裂以前一直在快速发展。不过随后由于投资断流，公司一度萎缩，软件开发也基本上陷入休眠状态，看起来离倒闭的日子不远了。但在 2002 年夏季，Evant 被一个世界排名前十的零售商看中。这家潜在的客户喜欢 Evant 的产品，但产品需要改变设计，以便扩展系统来支持大量库存规划操作。这是 Evant 的最后机会。

Although reduced to four developers, the team had assets. They were skilled, with knowledge of the domain, and one member had expertise in scaling issues. They had a very effective development culture. And they had a code base with a supple design that facilitated change. That summer, those four developers made a heroic development effort resulting in the ability to handle billions of planning elements and hundreds of users. On the strength of those capabilities, Evant won the behemoth client and, soon after, was bought by another company that wanted to leverage their software and their proven ability to accommodate new demands.

> 虽然项目人员已萎缩至 4 人，但团队仍然有实力。他们都具有精湛的技术，并且掌握了大量领域知识，而且其中一位成员还精通系统的扩展问题。他们有着非常高效的开发文化，代码库也实现了柔性设计，因此便于修改。在那个夏天，这 4 位开发人员经过艰巨的努力终于使系统能够处理数以十亿计的规划元素以及数百个用户。借助于这些强大功能，Evant 赢得了这家大客户。不久之后，它被另一家公司收购，这家公司希望利用他们的软件以及他们所展示出的能力来应对新的需求。

The domain-driven design culture (as well as the Extreme Programming culture) survived the transition and was revitalized. Today, the model and design continue to evolve, far richer and suppler two years later than when I made my contribution. And rather than being assimilated into the purchasing company, the members of the Evant team seem to be inspiring the company’s existing project teams to follow their lead. This story isn’t over yet.

> 领域驱动的设计文化（以及极限编程文化）在公司过渡期间幸存下来并获得了新生。现在，模型和设计仍在不断发展，比两年前我工作的时候要丰富和灵活得多。而且 Evant 团队并没有被收购它的公司同化，相反，在 Evant 团队成员的带动下，公司现有项目团队正在向 Evant 团队的开发文化转变。这个故事还远未结束。

No project will ever employ every technique in this book. Even so, any project committed to domain-driven design will be recognizable in a few ways. The defining characteristic is a priority on understanding the target domain and incorporating that understanding into the software. Everything else flows from that premise. Team members are conscious of the use of language on the project and cultivate its refinement. They are hard to satisfy with the quality of the domain model, because they keep learning more about the domain. They see continuous refinement as an opportunity and an ill-fitting model as a risk. They take design skill seriously because it isn’t easy to develop production-quality software that clearly reflects the domain model. They stumble over obstacles, but they hold on to their principles as they pick themselves up and continue forward.

> 没有哪个项目会用到本书中介绍的所有技术。尽管如此，我们很容易通过几个方面辨认出一个项目是否采用了领域驱动设计。标志性的特征是把“理解目标领域并将学到的知识融合到软件中”当作首要任务。其他工作都以它为前提。团队成员在项目中有意识地使用通用语言，并且不断对语言进行精化。由于他们不断地学习越来越多的领域知识，因此他们永远不会满足于现有领域模型的质量。他们把持续精化视作机会，把不适当的模型视作风险。他们知道，开发出高质量的、能够清晰反映出领域模型的软件并非易事，因此他们一丝不苟地运用设计技巧。他们也因为遇到障碍而跌倒过，但却始终坚持自己的原则，百折不挠，继续前进。

## LOOKING FORWARD 未来展望

Weather, ecosystems, and biology used to be considered messy, “soft” fields in contrast to physics or chemistry. Recently, however, people have recognized that the appearance of “messiness” in fact presents a profound technical challenge to discover and understand the order in these very complex phenomena. The field called “complexity” is the vanguard of many sciences. Although purely technological tasks have generally seemed most interesting and challenging to talented software engineers, domain-driven design opens up a new area of challenge that is at least equal. Business software does not have to be a bolted-together mess. Wrestling a complex domain into a comprehensible software design is an exciting challenge for strong technical people.

> 气候、生态系统和生物学以前被认为是杂乱无章的，是与物理或化学恰好相反的“软”领域。然而，近来人们认识到这种“混乱”的表象实际上提出了一个具有深远意义的技术挑战，这意味着要去发现和理解这些非常复杂的现象之中蕴含的规律。当下，“复杂性”领域是众多科学的前沿。虽然有才能的软件工程师通常都认为纯粹的技术任务是最有趣、最有挑战性的，但领域驱动设计展现了一个同样富有挑战性（甚至具有更大挑战性）的新领域。业务软件大可不必是拼凑而成的杂乱系统。与复杂的领域“搏斗”，把它转化为可理解的软件设计，这对于优秀的技术人员来说是一项激动人心的挑战。

We are nowhere near the era of laypeople creating complex software that works. Armies of programmers with rudimentary skills can produce certain kinds of software, but not the kind that saves a company in its eleventh hour. What is needed is for tool builders to put their minds to the task of extending the power and productivity of talented software developers. What is needed are sharper ways of exploring domain models and expressing them in working software. I look forward to experimenting with new tools and technologies devised for this purpose.

> 由外行创建复杂软件的时代还远未到来。虽然掌握了一些初级技术的众多编程人员可以开发出特定种类的软件，但他们绝对无法开发出能在危急关头拯救公司的软件。真正需要做的是：工具构建人员必须确保他们开发出的工具能够提高那些优秀软件开发人员的能力和工作效率。真正需要做的是：更加透彻地研究领域模型，并在可运行的软件中把它们表示出来。我非常希望能够尝试出于这个目的而设计的新工具和技术。

But though improved tools will be valuable, we mustn’t get distracted by them and lose sight of the core fact that creating good software is a learning and thinking activity. Modeling requires imagination and self-discipline. Tools that help us think or avoid distraction are good. Efforts to automate what must be the product of thought are naive and counterproductive.

> 然而，尽管好的工具很有价值，但我们不能把注意力都放在工具上而忽视掉一个基本事实——创建好的软件是一项需要学习和思考的活动。建模需要想象力和自律。好的工具能够帮助我们思考或避免分心。企图自动实现一些只有通过思考才能完成的任务是不切实际的，如果这样做的话，产生的效果只会适得其反。

With the tools and technology we already have, we can build systems much more valuable than most projects do today. We can write software that is a pleasure to use and a pleasure to work on, software that doesn’t box us in as it grows but creates new opportunities and continues to add value for its owners.

> 利用已有的工具和技术，我们可以开发出比当今大多数项目更有价值的系统。我们可以编写优秀的软件，这样的软件使用起来是一种乐趣，它在扩展的时候不会对我们构成限制，反而会为我们创造新的机会，并且会不断为其使用者提供价值。
