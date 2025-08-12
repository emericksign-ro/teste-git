# Coloque este arquivo em sistema_completo/tools e rode Seed_Dados.bat depois que a API estiver ON
import requests
BASE='http://localhost:5000/api'
def p(u,d):
    try:
        r=requests.post(u,json=d,timeout=10)
        print(u, r.status_code, r.text[:150])
    except Exception as e:
        print('ERRO',u,e)
p(f"{BASE}/clientes", {'nome':'Cliente Demo','email':'demo@ex.com','telefone':'(11) 99999-0000'})
p(f"{BASE}/produtos", {'nome':'Toldo 3x2','preco':1500,'estoque':10})
p(f"{BASE}/financeiro", {'tipo':'receita','valor':1500,'descricao':'Venda demo'})
