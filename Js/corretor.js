/*
Feito com empenho, música e insônia por Sérgio Freitas da Silva jr.
*/

function Wait()
{
    this.prom=new Promise((re,rj)=>{this.resolve=re;});
}

function range(a,b,inte=1)
{
    let r=[];
    for(i=a;i<b;i+=inte)r.push(i);
    return r;
}

let any={_any:true};
function _Tipo(tipo)
{
    this._tipo=tipo;
}
let Tipo=(tipo)=>new _Tipo(tipo);

function assert(condicao,mensagem)
{
    if(!condicao)throw mensagem;
}

function objcmp(a,b,subob=undefined)//Checa se a tem todas as propriedades de b com valores iguais
{
    //Como usaremos para comparar contextos, as exceções falam de "variáveis"
    for(key of Object.keys(b))
    {
        if(!key in a)throw "A "+(!subob?"variável/função "+key:"propriedade "+key+" de \""+subob+"\"")+" não existe.";
        if(typeof b[key]=="object"){
            if("_any" in b[key])continue;
            if("_tipo" in b[key])
            {
                if(typeof a[key]==b[key]._tipo)continue;
                throw "A "+(!subob?"variável/função "+key:"propriedade "+key+" de \""+subob+"\"")+" é de tipo diferente do esperado.";
            }
            if(typeof b[key]!=typeof a[key])throw "A "+(!subob?"variável/função "+key:"propriedade "+key+" de \""+subob+"\"")+" é de tipo diferente do esperado.";
            objcmp(a[key],b[key],!subob?key:key+" de "+subob)
        }
        else if (typeof a[key]!=typeof b[key])throw "A "+(!subob?"variável/função "+key:"propriedade "+key+" de \""+subob+"\"")+" é de tipo diferente do esperado.";
        else if(b[key]!=a[key])throw "A "+(!subob?"variável/função "+key:"propriedade "+key+" de \""+subob+"\"")+" possui valor diferente do esperado.";
    }
    return true;
}

//Criamos aqui um proxy para usar como contexto
//Isso foi feito para permitir que as variáveis que a pessoa cria como "globais" sejam na verdade propriedades de um objeto
//Assim podemos testar depois se estão com os valores certos mais facilmente
let pbj={};
pbj[Symbol.unscopables]={};
let proxy=new Proxy(pbj,{
    has:()=>true,
    get:(pbj,prop,rec)=>{if(prop=="console"){return window._console}else if(prop in window)return window[prop];if(prop in pbj)return pbj[prop]; else throw "\""+prop+"\" Indefinido"},
    set:(pbj,prop,val,rec)=>{if(prop=='_code'){window.code=val}else pbj[prop]=val;}
});

window._console={
    buf:"",
    log:(txt)=>{
        window._console.buf+=txt;
    }
};

function gambiarra(txt)
{
    //Transforma todos os "let"s em "var"s (let quebra o contexto);
    while(txt.indexOf("let ")!=-1)txt=txt.replace("let ","var ");
    //Cria referências externamente chamáveis para as funções e classes
    //txt=txt.replace(/function +(.+?)\((.*?)\)\s*\{(.*?\s*?)*?\}/g,"$&;_$1=$1;");
    txt=txt.replace(/function +(.+?)\((.*?)\)\s*\{/g,"$1=function ($2){");
    txt=txt.replace(/class +(.+?){/g,"$1=class {");
    /*let i;
    let c=0;
    for(m of txt.matchAll(/function\s+(.+?)\(.*?\)\s*{/g))
    {
        i=txt.indexOf(m[0])+m[0].length;
        while(txt[i]!="}"||c!=0){if(txt[i]=='{')c++;else if(txt[i]=='}')c--;i++;}
        i++;
        txt=txt.substr(0,i)+("_"+m[1]+"="+m[1]+";")+txt.substr(i);
    }
    c=0;
    for(m of txt.matchAll(/class\s+(.+?)\s*{/g))
    {
        i=txt.indexOf(m[0])+m[0].length;
        while(txt[i]!="}"||c!=0){if(txt[i]=='{')c++;else if(txt[i]=='}')c--;i++;}
        i++;
        txt=txt.substr(0,i)+("_"+m[1]+"="+m[1]+";")+txt.substr(i);
    }*/
    return txt;
}
console.log(gambiarra(`
function a(txt)
{
    alert(txt);
}

class b{
    constructor(t){
        this.type=t;
    }
}
`));

function executar(txt)
{
    proxy._code=gambiarra(txt);
    with(proxy){eval(code)};
}

let _questoes=[];

function hr()
{
    return document.createElement("hr");
}

class Questao
{
    constructor(texto,tela,modelo={},testador=(contexto)=>{},titulo="",preexec=()=>{},reset=``,clas="")
    {
        this.texto=texto;
        this.preexec=preexec;
        this.modelo=modelo;
        this.testador=testador;
        this.el=document.createElement("div");
        this.el.className="q"+(_questoes.length+1);
        this.el.id=this.el.className;
        this.reset=reset;
        this.el.style.width="100%";
        this.code=document.createElement("textarea");
        //APAGUE ISSO
        //this.code.value=gabaritos[_questoes.length+1];
        this.code.onkeydown=(e)=>{
            let _e=e;
            if(_e.keyCode==9)
            {
                _e.preventDefault();
                let val=this.code.value;
                let [s,e]=[this.code.selectionStart,this.code.selectionEnd];
                this.code.value=val.substr(0,s)+"\t"+val.substr(e);
                this.code.selectionEnd=this.code.selectionStart=s+1;
            }
        }
        this.code.style.width="100%";
        let prev=document.body.getElementsByClassName(this.el.id);
        if(prev.length!=0)
        {
            document.body.removeChild(prev[0]); 
            this.code.value=prev[0].getElementsByTagName("textarea")[0].value;
        }
        let h1=document.createElement("h2");
        h1.style.width="100%";
        h1.innerHTML="Questão "+(_questoes.length+1)+(titulo.length>0?":"+titulo:"");
        let text=document.createElement("p");
        text.style.width="100%";
        text.innerHTML=this.texto;
        this.msg=document.createElement("p");
        this.msg.style.width="100%";
        this.msg.innerHTML="";
        this.msg.style.color="red";
        let bot=document.createElement("button");
        bot.innerHTML="Testar código";
        bot.style.width="100%";
        bot.onclick=()=>this.tentativa;
        this.el.appendChild(h1);
        this.el.appendChild(text);
        this.el.appendChild(this.code);
        this.el.appendChild(this.msg);
        this.el.appendChild(bot);
        this.res=document.createElement("div");
        this.res.className=clas;
        this.el.appendChild(this.res);
        _questoes.push(this);
        tela.appendChild(this.el);
        tela.appendChild(document.createElement("br"));
        tela.appendChild(hr());
        this.res.innerHTML=this.reset;
    }
    get tentativa()
    {
        this.res.innerHTML=this.reset;
        this.msg.style.color="red";
        this.code.style.background="white";
        try
        {
            this.preexec();
            executar(this.code.value);
            objcmp(pbj,this.modelo)
            this.testador(pbj);
        }
        catch(e)
        {
            if(typeof e=="string")this.msg.innerHTML=e;
            else {this.msg.innerHTML="Linha "+e.lineNumber+":"+e.columnNumber+":"+e.message;}
            return false;
        }
        this.msg.style.color="green";
        this.code.style.background="lightgreen";
        this.msg.innerHTML="Ok.";
        return pbj;
    }
}