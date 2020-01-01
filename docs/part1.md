# 第一部分 运用领域模型

> I: Putting the Domain Model to Work

Image
This eighteenth-century Chinese map represents the whole world. In the center and taking up most of the space is China, surrounded by perfunctory representations of other countries. This was a model of the world appropriate to that society, which had intentionally turned inward. The worldview that the map represents must not have been helpful in dealing with foreigners. Certainly it would not serve modern China at all. Maps are models, and every model represents some aspect of reality or an idea that is of interest. A model is a simplification. It is an interpretation of reality that abstracts the aspects relevant to solving the problem at hand and ignores extraneous detail.

> 上面这张图是 18 世纪中国描绘的世界地图。图中央最大的部分是中国，其周围散布着其他国家，但这些国家只是草草地表示了一下。这是适用于当时中国社会的世界模型，它意在关注中国自身。然而，这幅地图所呈现的世界观对于处理外交事务并无助益。当然，它对现代中国也毫无用处。地图就是模型，而模型被用来描绘人们所关注的现实或想法的某个方面。模型是一种简化。它是对现实的解释——把与解决问题密切相关的方面抽象出来，而忽略无关的细节。

Every software program relates to some activity or interest of its user. That subject area to which the user applies the program is the domain of the software. Some domains involve the physical world: The domain of an airline-booking program involves real people getting on real aircraft. Some domains are intangible: The domain of an accounting program is money and finance. Software domains usually have little to do with computers, though there are exceptions: The domain of a source-code control system is software development itself.

> 每个软件程序是为了执行用户的某项活动，或是满足用户的某种需求。这些用户应用软件的问题区域就是软件的领域。一些领域涉及物质世界，例如，机票预订程序的领域中包括飞机乘客在内。有些领域则是无形的，例如，会计程序的金融领域。软件领域一般与计算机关系不大，当然也有例外，例如，源代码控制系统的领域就是软件开发本身。

To create software that is valuably involved in users’ activities, a development team must bring to bear a body of knowledge related to those activities. The breadth of knowledge required can be daunting. The volume and complexity of information can be overwhelming. Models are tools for grappling with this overload. A model is a selectively simplified and consciously structured form of knowledge. An appropriate model makes sense of information and focuses it on a problem.

> 为了创建真正能为用户活动所用的软件，开发团队必须运用一整套与这些活动有关的知识体系。所需知识的广度可能令人望而生畏，庞大而复杂的信息也可能超乎想象。模型正是解决此类信息超载问题的工具。模型这种知识形式对知识进行了选择性的简化和有意的结构化。适当的模型可以使人理解信息的意义，并专注于问题。

A domain model is not a particular diagram; it is the idea that the diagram is intended to convey. It is not just the knowledge in a domain expert’s head; it is a rigorously organized and selective abstraction of that knowledge. A diagram can represent and communicate a model, as can carefully written code, as can an English sentence.

> 领域模型并非某种特殊的图，而是这种图所要传达的思想。它绝不单单是领域专家头脑中的知识，而是对这类知识严格的组织且有选择的抽象。图可以表示和传达一种模型，同样，精心书写的代码或文字也能达到同样的目的。

Domain modeling is not a matter of making as “realistic” a model as possible. Even in a domain of tangible real-world things, our model is an artificial creation. Nor is it just the construction of a software mechanism that gives the necessary results. It is more like moviemaking, loosely representing reality to a particular purpose. Even a documentary film does not show unedited real life. Just as a moviemaker selects aspects of experience and presents them in an idiosyncratic way to tell a story or make a point, a domain modeler chooses a particular model for its utility.

> 领域建模并不是要尽可能建立一个符合“现实”的模型。即使是对具体、真实世界中的事物进行建模，所得到的模型也不过是对事物的一种模拟。它也不单单是为了实现某种目的而构造出来的软件机制。建模更像是制作电影——出于某种目的而概括地反映现实。即使是一部纪录片也不会原封不动地展现真实生活。就如同电影制片人讲述故事或阐明观点时，他们会选择素材，并以一种特殊方式将它们呈现给观众，领域建模人员也会依据模型的作用来选择具体的模型。

## THE UTILITY OF A MODEL IN DOMAIN-DRIVEN DESIGN 模型在领域驱动设计中的作用

In domain-driven design, three basic uses determine the choice of a model.

> 在领域驱动的设计中，3 个基本用途决定了模型的选择。

1. The model and the heart of the design shape each other. It is the intimate link between the model and the implementation that makes the model relevant and ensures that the analysis that went into it applies to the final product, a running program. This binding of model and implementation also helps during maintenance and continuing development, because the code can be interpreted based on understanding the model. (See Chapter 3.)
2. The model is the backbone of a language used by all team members. Because of the binding of model and implementation, developers can talk about the program in this language. They can communicate with domain experts without translation. And because the language is based on the model, our natural linguistic abilities can be turned to refining the model itself. (See Chapter 2.)
3. The model is distilled knowledge. The model is the team’s agreed-upon way of structuring domain knowledge and distinguishing the elements of most interest. A model captures how we choose to think about the domain as we select terms, break down concepts, and relate them. The shared language allows developers and domain experts to collaborate effectively as they wrestle information into this form. The binding of model and implementation makes experience with early versions of the software applicable as feedback into the modeling process. (See Chapter 1.)

---

> 1. 模型和设计的核心互相影响。正是模型与实现之间的紧密联系才使模型变得有用，并确保我们在模型中所进行的分析能够转化为最终产品（即一个可运行的程序）。模型与实现之间的这种紧密结合在维护和后续开发期间也会很有用，因为我们可以基于对模型的理解来解释代码。（参见第 3 章）
> 2. 模型是团队所有成员使用的通用语言的中枢。由于模型与实现之间的关联，开发人员可以使用该语言来讨论程序。他们可以在无需翻译的情况下与领域专家进行沟通。而且，由于该语言是基于模型的，因此我们可借助自然语言对模型本身进行精化。（参见第 2 章）
> 3. 模型是浓缩的知识。模型是团队一致认同的领域知识的组织方式和重要元素的区分方式。透过我们如何选择术语、分解概念以及将概念联系起来，模型记录了我们看待领域的方式。当开发人员和领域专家在将信息组织为模型时，这一共同的语言（模型）能够促使他们高效地协作。模型与实现之间的紧密结合使来自软件早期版本的经验可以作为反馈应用到建模过程中。（参见第 1 章）

The next three chapters set out to examine the meaning and value of each of these contributions in turn, and the ways they are intertwined. Using a model in these ways can support the development of software with rich functionality that would otherwise take a massive investment of ad hoc development.

> 接下来的 3 章分别考查上述 3 种基本用途的意义和价值，以及它们之间的关联方式。遵循这些原则使用模型可以很好地支持具有丰富功能的软件的开发，否则就需要耗费大规模投资进行专门开发。

## THE HEART OF SOFTWARE 软件的核心

The heart of software is its ability to solve domain-related problems for its user. All other features, vital though they may be, support this basic purpose. When the domain is complex, this is a difficult task, calling for the concentrated effort of talented and skilled people. Developers have to steep themselves in the domain to build up knowledge of the business. They must hone their modeling skills and master domain design.

> 软件的核心是其为用户解决领域相关的问题的能力。所有其他特性，不管有多么重要，都要服务于这个基本目的。当领域很复杂时，这是一项艰巨的任务，要求高水平技术人员的共同努力。开发人员必须钻研领域以获取业务知识。他们必须磨砺其建模技巧，并精通领域设计。

Yet these are not the priorities on most software projects. Most talented developers do not have much interest in learning about the specific domain in which they are working, much less making a major commitment to expand their domain-modeling skills. Technical people enjoy quantifiable problems that exercise their technical skills. Domain work is messy and demands a lot of complicated new knowledge that doesn’t seem to add to a computer scientist’s capabilities.

> 然而，在大多数软件项目中，这些问题并未引起足够的重视。大部分有才能的开发人员对学习与他们的工作领域有关的知识不感兴趣，更不会下力气去扩展自己的领域建模技巧。技术人员喜欢那些能够提高其技能的可量化问题。领域工作很繁杂，而且要求掌握很多复杂的新知识，而这些新知识看似对提高计算机科学家的能力并无裨益。

Instead, the technical talent goes to work on elaborate frameworks, trying to solve domain problems with technology. Learning about and modeling the domain is left to others. Complexity in the heart of software has to be tackled head-on. To do otherwise is to risk irrelevance.

> 相反，技术人才更愿意从事精细的框架工作，试图用技术来解决领域问题。他们把学习领域知识和领域建模的工作留给别人去做。软件核心的复杂性需要我们直接去面对和解决，如果不这样做，则可能导致工作重点的偏离。

In a TV talk show interview, comedian John Cleese told a story of an event during the filming of Monty Python and the Holy Grail. They had been shooting a particular scene over and over, but somehow it wasn’t funny. Finally, he took a break and consulted with fellow comedian Michael Palin (the other actor in the scene), and they came up with a slight variation. They shot one more take, and it turned out funny, so they called it a day.

> 在一次电视访谈节目中，喜剧演员 John Cleese 讲述了电影《巨蟒和圣杯》（Monty Pythonand the Holy Grail）在拍摄期间发生的一个小故事。有一幕他们反复拍了很多次，但就是感觉不够滑稽。最后，他停下来，与另一位喜剧演员 Michael Palin（该幕中的另一位演员）商量了一下，他们决定稍微改变一下。随后又拍了一次，终于令他们满意了，于是收工。

The next morning, Cleese was looking at the rough cut the film editor had put together of the previous day’s work. Coming to the scene they had struggled with, Cleese found that it wasn’t funny; one of the earlier takes had been used.

> 第二天早上，Cleese 观看了剪辑人员为前一天工作所做的粗剪。到了那个令他们颇费周章的场景时，Cleese 发现剪辑人员竟然使用了先前拍摄的一个镜头，影片到这里又变得不滑稽了。

He asked the film editor why he hadn’t used the last take, as directed. “Couldn’t use it. Someone walked in-shot,” the editor replied. Cleese watched the scene again, and then again. Still he could see nothing wrong. Finally, the editor stopped the film and pointed out a coat sleeve that was visible for a moment at the edge of the picture.

> 他问剪辑人员为什么没有按要求使用最后拍的那个镜头，剪辑人员回答说：“那个镜头不能用，因为有人闯入了镜头。”Cleese 连看了两遍，仍未发现有什么不妥。最后，剪辑人员将影片暂停，并指出在屏幕边缘有一只一闪而过的大衣袖子。

The film editor was focused on the precise execution of his own specialty. He was concerned that other film editors who saw the movie would judge his work based on its technical perfection. In the process, the heart of the scene had been lost (“The Late Late Show with Craig Kilborn,” CBS, September 2001).

> 影片的剪辑人员专注于准确完成自己的工作。他担心其他看到这部电影的剪辑人员会给他挑错。在这个过程中，镜头的核心作用被忽略了（“The Late Late Show with Craig Kilborn”, CBS,2001 年 9 月）。

Fortunately, the funny scene was restored by a director who understood comedy. In just the same way, leaders within a team who understand the centrality of the domain can put their software project back on course when development of a model that reflects deep understanding gets lost in the shuffle.

> 幸运的是，该剧的导演很懂喜剧，他最终使用了那个镜头。同样，在一个团队中，反映了对领域深层次理解的模型开发有时也会在混乱中迷失方向，此时，理解领域核心的领导者能够将软件项目带回到正确的轨道上来。

This book will show that domain development holds opportunities to cultivate very sophisticated design skills. The messiness of most software domains is actually an interesting technical challenge. In fact, in many scientific disciplines, “complexity” is one of the most exciting current topics, as researchers attempt to tackle the messiness of the real world. A software developer has that same prospect when facing a complicated domain that has never been formalized. Creating a lucid model that cuts through that complexity is exciting.

> 本书将展示领域开发中蕴藏的巨大机会，它能够培养精湛的设计技巧。大多数混乱的软件领域其实是一项充满乐趣的技术挑战。事实上，在许多科学领域中，“复杂性”都是当前最热门的话题之一，因为研究人员都在想办法解决真实世界中的复杂性。软件开发人员在面对尚未规范的复杂领域时，也会有同样的期望。创建一个克服这些复杂性的易懂模型会带来巨大的成就感。

There are systematic ways of thinking that developers can employ to search for insight and produce effective models. There are design techniques that can bring order to a sprawling software application. Cultivation of these skills makes a developer much more valuable, even in an initially unfamiliar domain.

> 开发人员可以采用一些系统性的思考方法来透彻地理解领域并开发出有效的模型。还有一些设计技巧可以使毫无头绪的软件应用变得井井有条。掌握这些技能可以令开发人员的价值倍增，即使是在一个最初不熟悉的领域中也是如此。
