<?php
$servername = "localhost";
$username = "root";
$password = "";
$conn = new mysqli($servername, $username, $password);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$sql = "CREATE DATABASE IF NOT EXISTS cadastro_de_clientes";
if (!$conn->query($sql) === TRUE) {
    echo "Erro ao criar banco de dados: " . $conn->error;
}
$sql = "CREATE TABLE IF NOT EXISTS cadastro_de_clientes.cliente (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    contato VARCHAR(20) NOT NULL
    )";
if ($conn->query($sql) === FALSE) {
    echo "Erro ao criar tabela: " . $conn->error;
}

$metodoHttp = $_SERVER['REQUEST_METHOD'];
if ($metodoHttp == 'POST') {
	$stmt = $conn->prepare(
		"INSERT INTO cadastro_de_clientes.cliente (nome, endereco, contato) VALUES (?, ?, ?)");
    $json = json_decode(file_get_contents('php://input'));
    $nome     = $json->{'nome'};
    $endereco = $json->{'endereco'};
    $contato = $json->{'contato'};
    $stmt->bind_param("sss", $nome, $endereco, $contato);
    $stmt->execute();
    $stmt->close();
    $id = $conn->insert_id;
    $jsonRetorno = array("id"=>$id);
    echo json_encode($jsonRetorno);

} else if ($metodoHttp == 'GET') {
    $segments = explode("/", $_SERVER["REQUEST_URI"]);
    $id = $segments[count($segments)-1];
    $jsonArray = array();
        if($id == null)//verifica se foi passado um id
            $sql = "SELECT id, nome, endereco, contato FROM cadastro_de_clientes.cliente";
        else
            $sql = "SELECT id, nome, endereco, contato FROM cadastro_de_clientes.cliente WHERE id=$id";

    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $jsonLinha = array(
                 "id"       => $row["id"],
                "nome"     => $row["nome"],
                "endereco" => $row["endereco"],
                "contato" => $row["contato"]);
            $jsonArray[] = $jsonLinha;    	    
        }
    }
    echo json_encode($jsonArray);

} else if ($metodoHttp == 'PUT') {
    $stmt = $conn->prepare(
        "UPDATE cadastro_de_clientes.cliente SET nome=?, endereco=?, contato=?  WHERE id=?");
    $json  = json_decode(file_get_contents('php://input'));
    $id       = $json->{'id'};
    $nome     = $json->{'nome'};
    $endereco = $json->{'endereco'};
    $contato = $json->{'contato'};
    $stmt->bind_param("sssi", $nome, $endereco, $contato, $id);
    $stmt->execute();
    $stmt->close();
    $jsonRetorno = array("id"=>$id);
    echo json_encode($jsonRetorno);

} else if ($metodoHttp == 'DELETE') {
    $stmt = $conn->prepare("DELETE FROM cadastro_de_clientes.cliente WHERE id=?");
    $segments = explode("/", $_SERVER["REQUEST_URI"]);
    $id = $segments[count($segments)-1];
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $stmt->close();
    $jsonRetorno = array("id"=>$id);
    echo json_encode($jsonRetorno);
}

$conn->close();

//para o put 
/*{
    "id": 1,
    "nome": "Israel Hudson",
    "endereco": "Rua dos lltapebas",
    "contato": "DFD"
}*/
?>